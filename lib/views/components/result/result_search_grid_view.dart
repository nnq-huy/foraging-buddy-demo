import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/providers/results_by_search_term_provider.dart';
import 'package:foraging_buddy/views/components/result/results_sliver_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/views/components/animations/data_not_found_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';

class ResultsSearchGridView extends ConsumerWidget {
  final String searchTerm;

  const ResultsSearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      resultsBySearchTermProvider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (results) {
        if (results.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        } else {
          return ResultsSliverGridView(
            results: results,
          );
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