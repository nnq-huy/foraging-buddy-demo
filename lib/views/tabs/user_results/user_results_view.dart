import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/identifier/providers/user_result_provider.dart';
import 'package:foraging_buddy/state/providers/result_map_view_state_provider.dart';
import 'package:foraging_buddy/views/tabs/user_results/result_map_view.dart';
import 'package:foraging_buddy/views/identifier/mushroom_recognizer_view.dart';
import 'package:foraging_buddy/views/tabs/user_results/result_search_view.dart';
import 'package:foraging_buddy/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/error_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/loading_animation_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';

class UserResultsView extends ConsumerWidget {
  const UserResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(userResultsProvider);
    final isMap = ref.watch(isResultMapProvider);
    final mapState = ref.read(isResultMapProvider.notifier);
    return results.when(
      data: (results) {
        if (results.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MushroomRecognizer()));
                    },
                    label: const Text(Strings.identify),
                    icon: const Icon(Icons.search),
                  ),
                ),
                const EmptyContentsWithTextAnimationView(
                  text: Strings.youHaveNoPosts,
                ),
              ],
            ),
          );
        } else {
          return Stack(children: [
            isMap
                ? ResultsMapView(
                    results: results,
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(userResultsProvider);
                      return Future.delayed(
                        const Duration(
                          seconds: 1,
                        ),
                      );
                    },
                    child: const ResultSearchView(),
                  ),
            //button to toggle between map nad grid view
            Positioned(
              left: 10,
              top: 10,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    label: isMap
                        ? const Text(Strings.gridView)
                        : const Text(Strings.mapView),
                    icon:
                        isMap ? const Icon(Icons.list) : const Icon(Icons.map),
                    onPressed: () {
                      mapState.toogle();
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MushroomRecognizer()));
                    },
                    label: const Text(Strings.identify),
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
            )
          ]);
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
