import 'package:flutter/material.dart';
import 'package:foraging_buddy/extensions/get_img_file_names.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:foraging_buddy/state/guides/providers/selected_id_provider.dart';
import 'package:foraging_buddy/views/components/guides/guide_details_view.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GuidesListView extends ConsumerWidget {
  final List<Mushroom> guides;
  const GuidesListView({
    super.key,
    required this.guides,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listviewHeight = 0.75 * MediaQuery.of(context).size.height;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SizedBox(
      height: listviewHeight,
      width: 400,
      child: ListView.builder(
          itemCount: guides.length,
          itemBuilder: (context, index) {
            final mushroom = guides.elementAt(index);
            final imageFileNames = getImageFileNames(mushroom.latinName);
            return GestureDetector(
              onTap: () {
                if (isMobile) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MushroomDetailsView(mushroom: mushroom),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text('Close'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ref.read(selectedIdProvider.notifier).setId(id: mushroom.id);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  shape: const StadiumBorder(
                      side: BorderSide(color: AppColors.lightGrey)),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(imageFileNames.first),
                  ),
                  title: Text(
                    mushroom.name,
                  ),
                  subtitle: Text(
                    mushroom.latinName,
                    style: AppTextStyles.listSmall,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
