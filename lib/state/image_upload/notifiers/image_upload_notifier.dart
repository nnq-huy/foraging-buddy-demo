import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foraging_buddy/extensions/determine_position.dart';
import 'package:foraging_buddy/state/constants/firebase_collection_name.dart';
import 'package:foraging_buddy/state/image_upload/constants/constants.dart';
import 'package:foraging_buddy/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:foraging_buddy/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:foraging_buddy/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:foraging_buddy/state/posts/models/post_payload.dart';
import "package:image/image.dart" as img;
import 'package:flutter/foundation.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';
import 'package:foraging_buddy/state/image_upload/typedefs/is_loading.dart';
import 'package:foraging_buddy/state/posts/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required UserId userId,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;
    late Uint8List resizedUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          return false;
        }
//create resized image
        final resizedImage = img.copyResize(
          fileAsImage,
          width: Constants.imageMaxWidth,
        );
        final resizedImageData = img.encodeJpg(resizedImage);
        resizedUint8List = Uint8List.fromList(resizedImageData);
        //create thumbnail
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;

      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }
    //get current location info
    final currentLocation = await determinePosition();
    //get location from coordinates
    final placeMarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    final locationData = placeMarks.first;
    final location =
        '${locationData.postalCode!}, ${locationData.locality!}, ${locationData.country!}';

    //calculate aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();

    //get file name
    final fileName = const Uuid().v4();

    //create references to the thumbnail and the image
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      //upload thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      //upload original file
      final originalFileUploadTask =
          await originalFileRef.putData(resizedUint8List);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      //upload post payload
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        location: location,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
