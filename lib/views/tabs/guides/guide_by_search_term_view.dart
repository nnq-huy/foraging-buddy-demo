import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foraging_buddy/state/guides/providers/mushroom_by_id_provider.dart';
import 'package:foraging_buddy/state/guides/providers/selected_id_provider.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/loading_animation_view.dart';
import 'package:foraging_buddy/views/components/guides/guide_details_view.dart';
import 'package:foraging_buddy/views/components/guides/guide_search_list_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/extensions/dismiss_keyboard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GuideSearchView extends HookConsumerWidget {
  const GuideSearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedIdProvider);
    final selectedMushroom = ref.watch(mushroomByIdProvider(selectedId));
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
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
    if (isMobile) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: Strings.searchMushrooms,
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
          GuidesSearchListView(
            searchTerm: searchTerm.value,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: 250,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: Strings.enterYourSearchTermHere,
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
                GuidesSearchListView(
                  searchTerm: searchTerm.value,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 250,
            child: selectedMushroom.when(data: (data) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: MushroomDetailsView(mushroom: data),
              );
            }, error: (error, stackTrace) {
              return const ErrorAnimationView();
            }, loading: () {
              return const LoadingAnimationView();
            }),
          ),

          //MushroomDetailsView(mushroom: ref.watch(selectedMushroomProvider(2)))
        ],
      );
    }
  }
}
