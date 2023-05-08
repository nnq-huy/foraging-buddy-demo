import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/guides/providers/mushrooms_by_search_term_provider.dart';
import 'package:foraging_buddy/views/components/guides/guides_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/views/components/animations/data_not_found_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';

class GuidesSearchListView extends ConsumerWidget {
  final String searchTerm;

  const GuidesSearchListView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guides = ref.watch(
      mushroomsBySearchTermProvider(
        searchTerm,
      ),
    );

    return guides.when(
      data: (guides) {
        if (guides.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        } else {
          return SliverToBoxAdapter(
              child: GuidesListView(
            guides: guides,
          ));
        }
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: ErrorAnimationView(),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
