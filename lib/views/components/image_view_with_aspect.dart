import 'package:flutter/material.dart';

class ImageViewWithAspect extends StatelessWidget {
  final String fileUrl;
  final double aspectRatio;
  const ImageViewWithAspect({
    super.key,
    required this.fileUrl,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.4;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image.network(
          fileUrl,
          fit: BoxFit.scaleDown,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
