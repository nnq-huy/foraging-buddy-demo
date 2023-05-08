
import 'package:foraging_buddy/state/identifier/typedefs/is_map.dart';
import 'package:foraging_buddy/state/notifiers/is_result_map_notitier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isResultMapProvider = StateNotifierProvider<IsResultMapNotifier, IsMap>(
  (ref) => IsResultMapNotifier(),
);
