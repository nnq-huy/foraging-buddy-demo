
import 'package:foraging_buddy/state/identifier/typedefs/is_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsResultMapNotifier extends StateNotifier<IsMap> {
  IsResultMapNotifier() : super(false);
  void toogle() {
    state = !state;
  }
}
