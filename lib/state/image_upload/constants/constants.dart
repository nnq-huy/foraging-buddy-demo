import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  // for photos
  static const imageThumbnailWidth = 150;
  static const imageMaxWidth = 800;
  static const imageMaxHeight = 800;

  // for videos
  static const videoThumbnailMaxHeight = 400;
  static const videoThumbnailQuality = 75;

  const Constants._();
}
