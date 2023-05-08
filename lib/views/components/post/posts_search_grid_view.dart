import 'package:flutter/material.dart';
import 'package:foraging_buddy/views/components/post/posts_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:foraging_buddy/views/components/animations/data_not_found_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';

class PostsSearchListView extends ConsumerWidget {
  final String searchTerm;

  const PostsSearchListView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(
      postsBySearchTermProvider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        } else {
          return SliverToBoxAdapter(
            child: PostsListView(
              posts: posts,
            ),
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
