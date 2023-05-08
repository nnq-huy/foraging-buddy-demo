import 'package:foraging_buddy/state/identifier/typedefs/is_map.dart';
import 'package:foraging_buddy/state/notifiers/is_post_map_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isPostMapProvider = StateNotifierProvider<IsPostMapNotifier, IsMap>(
  (ref) => IsPostMapNotifier(),
);
