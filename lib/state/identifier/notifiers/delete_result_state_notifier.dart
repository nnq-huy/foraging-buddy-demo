import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/constants/firebase_collection_name.dart';
import 'package:foraging_buddy/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:foraging_buddy/state/image_upload/typedefs/is_loading.dart';

class DeleteResultStateNotifier extends StateNotifier<IsLoading> {
  DeleteResultStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteResult({
    required Result result,
  }) async {
    try {
      isLoading = true;

      // delete the post's thumbnail

      await FirebaseStorage.instance
          .ref()
          .child(result.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(result.thumbnailStorageId)
          .delete();

      // delete the post's original file (video or image)

      await FirebaseStorage.instance
          .ref()
          .child(result.userId)
          .child(result.fileType.collectionName)
          .child(result.originalFileStorageId)
          .delete();

      // finally delete the post itself

      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.results)
          .where(
            FieldPath.documentId,
            isEqualTo: result.resultId,
          )
          .limit(1)
          .get();
      for (final post in postInCollection.docs) {
        await post.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
