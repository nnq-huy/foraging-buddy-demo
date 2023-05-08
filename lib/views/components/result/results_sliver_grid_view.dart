import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/views/components/result/result_thumbnail_view.dart';
import 'package:foraging_buddy/views/result_details/result_details_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResultsSliverGridView extends StatelessWidget {
  final Iterable<Result> results;
  const ResultsSliverGridView({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 3 : 6,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: results.length,
        (context, index) {
          final result = results.elementAt(index);
          return ResultThumbnailView(
            result: result,
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultDetailsView(
                    result: result,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
