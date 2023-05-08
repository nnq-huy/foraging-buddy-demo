import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foraging_buddy/views/components/post/posts_search_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/extensions/dismiss_keyboard.dart';

class PostSearchView extends HookConsumerWidget {
  const PostSearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');

    useEffect(
      () {
        controller.addListener(() {
          searchTerm.value = controller.text;
        });
        return () {};
      },
      [controller],
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 50, 8, 8),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: Strings.searchPosts,
                labelStyle: const TextStyle(fontSize: 14),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    dismissKeyboard();
                  },
                ),
              ),
            ),
          ),
        ),
        PostsSearchListView(
          searchTerm: searchTerm.value,
        ),
      ],
    );
  }
}
