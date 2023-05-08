import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/classifier.dart';
import 'package:foraging_buddy/state/identifier/models/classifier_category.dart';
import 'package:foraging_buddy/state/identifier/models/result_status.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/save_result/save_result_view.dart';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'mushroom_photo_view.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class MushroomRecognizer extends StatefulWidget {
  const MushroomRecognizer({super.key});

  @override
  State<MushroomRecognizer> createState() => _MushroomRecognizerState();
}

class _MushroomRecognizerState extends State<MushroomRecognizer> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  // Result
  ResultStatus _resultStatus = ResultStatus.notStarted;
  String _mushroomLabel = ''; // Name of Error Message
  double _accuracy = 0.0;
  List<ClassifierCategory> _categories = [];
  //Camera

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mushroom Identifier'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            child: _buildPhotoView(),
            onTap: () => _onPickPhoto(ImageSource.gallery),
          ),
          const SizedBox(height: 10),
          buildResultView(),
          const Spacer(
            flex: 2,
          ),
          _buildPickPhotoButton(
            title: Strings.takePhoto,
            source: ImageSource.camera,
          ),
          _buildPickPhotoButton(
            title: Strings.pickPhoto,
            source: ImageSource.gallery,
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _buildPhotoView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        MushroomPhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text(Strings.analyzing, style: AppTextStyles.analyzing);
  }

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
  }) {
    return TextButton(
      onPressed: () => _onPickPhoto(source),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.brown,
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (source == ImageSource.camera)
                ? const Icon(Icons.camera_alt_outlined)
                : const Icon(Icons.photo_library_outlined),
            const SizedBox(
              width: 8,
            ),
            Text(title, style: AppTextStyles.identifierButton),
          ],
        )),
      ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategories = _classifier.predict(imageInput);

    final result = resultCategories.first.score >= 0.8
        ? ResultStatus.found
        : ResultStatus.notFound;
    final mushroomLabel = resultCategories.first.label;
    final accuracy = resultCategories.first.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _mushroomLabel = mushroomLabel;
      _accuracy = accuracy;
      _categories = resultCategories;
    });
  }

  Widget buildResultView() {
    var title = '';

    if (_resultStatus == ResultStatus.notFound) {
      title = Strings.failToRecognize;
    } else if (_resultStatus == ResultStatus.found) {
      title = _mushroomLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == ResultStatus.found) {
      accuracyLabel =
          '${Strings.accuracy}: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    return Column(
      children: [
        Text(title, style: AppTextStyles.result),
        const SizedBox(height: 10),
        Text(accuracyLabel, style: AppTextStyles.resultRating),
        _resultStatus == ResultStatus.found
            ? TextButton(
                onPressed: () async {
                  if (!mounted) {
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SaveResultView(
                                categories: _categories,
                                fileToPost: _selectedImageFile!,
                                fileType: FileType.image,
                              )));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.brown,
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.upload_outlined),
                      Text(Strings.uploadResult,
                          style: AppTextStyles.identifierButton),
                    ],
                  )),
                ),
              )
            : Container()
      ],
    );
  }
}
