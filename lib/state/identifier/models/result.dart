import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:foraging_buddy/state/identifier/models/classifier_category.dart';
import 'package:foraging_buddy/state/identifier/models/result_key.dart';
import 'package:foraging_buddy/state/identifier/typedefs/result_id.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';

@immutable
class Result {
  final ResultId resultId;
  final DateTime createdAt;
  final String userId;
  final String title;
  final String thumbnailUrl;
  final String fileUrl;
  final String fileName;
  final FileType fileType;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final double? latitude;
  final double? longitude;
  final List<ClassifierCategory> resultCategories;

  const Result({
    required this.resultId,
    required this.createdAt,
    required this.userId,
    required this.title,
    required this.thumbnailUrl,
    required this.aspectRatio,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.originalFileStorageId,
    required this.resultCategories,
    required this.thumbnailStorageId,
    this.latitude,
    this.longitude,
  });
  factory Result.fromJson(Map<String, dynamic> json, String resultId) {
    final categoriesJson = json[ResultKey.resultCategories] as List;
    List<ClassifierCategory> categories =
        categoriesJson.map((e) => ClassifierCategory.fromJson(e)).toList();
    return Result(
      resultId: resultId,
      createdAt: (json[ResultKey.createdAt] as Timestamp).toDate(),
      userId: json[ResultKey.userId],
      title: json[ResultKey.title],
      thumbnailUrl: json[ResultKey.thumbnailUrl],
      aspectRatio: json[ResultKey.aspectRatio],
      fileName: json[ResultKey.fileName],
      fileType: FileType.image,
      fileUrl: json[ResultKey.fileUrl],
      originalFileStorageId: json[ResultKey.originalFileStorageId],
      resultCategories: categories,
      thumbnailStorageId: json[ResultKey.thumbnailStorageId],
      latitude: json[ResultKey.latitude],
      longitude: json[ResultKey.longitude],
    );
  }
}
