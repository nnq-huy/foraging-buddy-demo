import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';

class ResultThumbnailView extends StatelessWidget {
  final Result result;
  final VoidCallback onTapped;
  const ResultThumbnailView({
    Key? key,
    required this.result,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        result.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
