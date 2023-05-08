import 'package:foraging_buddy/state/guides/notifiers/selected_mushroom_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedIdProvider =
    StateNotifierProvider<SelectedMushroomIDNotifer, int>(
        (ref) => SelectedMushroomIDNotifer());
