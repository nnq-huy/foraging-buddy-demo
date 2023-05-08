
import 'package:foraging_buddy/state/guides/database/database_helper.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mushroomByIdProvider =
    FutureProvider.family<Mushroom, int>((ref, int id) {
  final selectedMushroom = getMushroom(id);
  return selectedMushroom;
});
