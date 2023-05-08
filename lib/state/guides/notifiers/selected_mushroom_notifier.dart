import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedMushroomIDNotifer extends StateNotifier<int> {
  SelectedMushroomIDNotifer() : super(1);
  void setId({required id}) {
    state = id;
  }
}
