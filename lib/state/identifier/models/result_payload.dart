import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;
import 'package:foraging_buddy/state/identifier/models/classifier_category.dart';
import 'package:foraging_buddy/state/identifier/models/result_key.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';
import 'package:foraging_buddy/state/posts/typedefs/user_id.dart';

@immutable
class ResultPayload extends MapView<String, dynamic> {
  ResultPayload({
    required UserId userId,
    required String title,
    required String thumbnailUrl,
    required String fileUrl,
    required String fileName,
    required FileType fileType,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required List<ClassifierCategory> resultCategories,
    double? latitude,
    double? longitude,
  }) : super(
          {
            ResultKey.userId: userId,
            ResultKey.title: title,
            ResultKey.createdAt: FieldValue.serverTimestamp(),
            ResultKey.thumbnailUrl: thumbnailUrl,
            ResultKey.fileUrl: fileUrl,
            ResultKey.fileName: fileName,
            ResultKey.fileType: fileType.name,
            ResultKey.aspectRatio: aspectRatio,
            ResultKey.thumbnailStorageId: thumbnailStorageId,
            ResultKey.originalFileStorageId: originalFileStorageId,
            ResultKey.resultCategories:
                resultCategories.map((e) => e.toJson()).toList(),
            ResultKey.latitude: latitude,
            ResultKey.longitude: longitude,
          },
        );
}
