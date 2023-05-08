import 'package:flutter/material.dart';
import 'package:foraging_buddy/views/tabs/user_posts/post_map_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/providers/post_map_view_state_provider.dart';
import 'package:foraging_buddy/views/create_new_post/create_new_post_view.dart';
import 'package:foraging_buddy/views/tabs/user_posts/post_search_view.dart';
import 'package:foraging_buddy/state/posts/providers/user_posts_provider.dart';
import 'package:foraging_buddy/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/loading_animation_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final posts = ref.watch(userPostsProvider);
    final isMap = ref.watch(isPostMapProvider);
    final mapState = ref.read(isPostMapProvider.notifier);
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CreateNewPostView()));
                    },
                    label: const Text(Strings.createNewPost),
                    icon: const Icon(Icons.new_label),
                  ),
                ),
                const EmptyContentsWithTextAnimationView(
                  text: Strings.youHaveNoPosts,
                ),
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              !isMobile
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 300,
                          child: PostSearchView(),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 300,
                          child: PostsMapView(posts: posts),
                        )
                      ],
                    )
                  : isMap
                      ? PostsMapView(
                          posts: posts,
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            ref.refresh(userPostsProvider);
                            return Future.delayed(
                              const Duration(
                                seconds: 1,
                              ),
                            );
                          },
                          child: const PostSearchView(),
                        ),
              Positioned(
                left: 10,
                top: 10,
                child: Row(
                  children: [
                    isMobile
                        ? ElevatedButton.icon(
                            label: isMap
                                ? const Text(Strings.listView)
                                : const Text(Strings.mapView),
                            icon: isMap
                                ? const Icon(Icons.list)
                                : const Icon(Icons.map),
                            onPressed: () {
                              mapState.toogle();
                            },
                          )
                        : Container(),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // go to the screen to create a new post
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateNewPostView(),
                          ),
                        );
                      },
                      label: const Text(Strings.createNewPost),
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              )
            ],
          );
        }
      },
      error: (error, stackTrace) {
        return const ErrorAnimationView();
      },
      loading: () {
        return const LoadingAnimationView();
      },
    );
  }
}
