import 'package:foraging_buddy/state/identifier/notifiers/send_result_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/image_upload/typedefs/is_loading.dart';

final resultUploaderProvider =
    StateNotifierProvider<ResultUploadNotifier, IsLoading>(
  (ref) => ResultUploadNotifier(),
);
