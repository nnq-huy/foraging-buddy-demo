import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/constants/styles.dart';

class MushroomPhotoView extends StatelessWidget {
  final File? file;
  const MushroomPhotoView({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 250,
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        color: AppColors.hunterGreen,
      ),
      child: (file == null)
          ? _buildEmptyView()
          : Image.file(file!, fit: BoxFit.cover),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
        child: Text(
      Strings.pleasePickPhoto,
      style: AppTextStyles.analyzing,
    ));
  }
}
