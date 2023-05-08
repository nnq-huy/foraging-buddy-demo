import 'package:foraging_buddy/state/guides/database/database_helper.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mushroomsProvider = FutureProvider<List<Mushroom>?>((ref) async {
  final mushrooms = getMushrooms();
  return mushrooms;
});
