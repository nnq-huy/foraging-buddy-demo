import 'package:foraging_buddy/state/identifier/notifiers/delete_result_state_notifier.dart';
import 'package:foraging_buddy/state/image_upload/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deleteResultrovider =
    StateNotifierProvider<DeleteResultStateNotifier, IsLoading>(
  (ref) => DeleteResultStateNotifier(),
);
