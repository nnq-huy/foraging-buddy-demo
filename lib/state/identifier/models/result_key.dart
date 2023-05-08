import 'package:flutter/foundation.dart' show immutable;

@immutable
class ResultKey {
  static const userId = 'uid';
  static const createdAt = 'created_at';
  static const thumbnailUrl = 'thumbnail_url';
  static const title = 'title';
  static const fileUrl = 'file_url';
  static const fileType = 'file_type';
  static const fileName = 'file_name';
  static const aspectRatio = 'aspect_ratio';
  static const thumbnailStorageId = 'thumbnail_storage_id';
  static const originalFileStorageId = 'original_file_storage_id';
  static const resultCategories = 'result_categories';
  static const latitude = 'latitude';
  static const longitude = 'longitude';

  const ResultKey._();
}
