/*mushroom details page, side list on iPad
	- list view on iPhone
	- details on the right on iPad
	- details on modal dialog on iPhone */

import 'package:flutter/material.dart';
import 'package:foraging_buddy/extensions/get_img_file_names.dart';
import 'package:foraging_buddy/state/guides/models/mushroom.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MushroomDetailsView extends StatelessWidget {
  final Mushroom mushroom;
  const MushroomDetailsView({
    super.key,
    required this.mushroom,
  });

  @override
  Widget build(BuildContext context) {
    final imageFileNames = getImageFileNames(mushroom.latinName);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            mushroom.name,
            style: AppTextStyles.mushroomBold,
          ),
          Text(
            mushroom.latinName,
            style: AppTextStyles.listSmall,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isMobile
                ? CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.5,
                    ),
                    items: [0, 1, 2].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image(
                              image: AssetImage(imageFileNames.elementAt(i)));
                        },
                      );
                    }).toList(),
                  )
                : Column(
                    children: [0, 1, 2].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                height: 250,
                                image: AssetImage(imageFileNames.elementAt(i))),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ),
          Text(mushroom.description),
          Text(''),
        ],
      ),
    );
  }
}
