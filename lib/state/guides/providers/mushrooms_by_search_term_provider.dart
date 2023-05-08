import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:foraging_buddy/state/guides/providers/mushrooms_provider.dart';
import 'package:foraging_buddy/state/posts/typedefs/search_term.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mushroomsBySearchTermProvider =
    FutureProvider.family<List<Mushroom>, SearchTerm>(
  (ref, SearchTerm searchTerm) async {
    List<Mushroom>? allMushrooms;

    ref.watch(mushroomsProvider).whenData((value) => {allMushrooms = value});
    final searchKey = searchTerm.toLowerCase();
    final results = allMushrooms!
        .where(
          (mushroom) =>
              mushroom.name.toLowerCase().contains(searchKey) ||
              mushroom.latinName.toLowerCase().contains(searchKey) ||
              mushroom.family.toLowerCase().contains(searchKey),
        )
        .toList();
    if (results.isEmpty) {
      return [];
    }
    return results;
  },
);
