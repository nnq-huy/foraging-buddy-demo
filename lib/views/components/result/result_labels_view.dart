import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';

class ResultLabelsView extends StatelessWidget {
  final Result result;

  const ResultLabelsView({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = result.resultCategories;
    final topResult = labels.elementAt(0);
    final secondResult = labels.elementAt(1);
    return Column(
      children: [
        const Text('Identifier result: '),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '${topResult.label} at ${(topResult.score * 100).toStringAsFixed(0)}%'),
            ),
            secondResult.score > 0.05
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${secondResult.label} at ${(secondResult.score * 100).toStringAsFixed(0)}%'),
                  )
                : Container()
          ],
        )
      ],
    );
  }
}
