import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:foraging_buddy/state/identifier/models/classifier_category.dart';
import 'package:foraging_buddy/state/identifier/providers/result_upload_provider.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';
import 'package:foraging_buddy/state/image_upload/models/thumbnail_request.dart';
import 'package:foraging_buddy/views/components/file_thumbnail_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cherry_toast/cherry_toast.dart';

class SaveResultView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  final List<ClassifierCategory> categories;
  const SaveResultView({
    super.key,
    required this.fileToPost,
    required this.fileType,
    required this.categories,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveResultViewState();
}

class _SaveResultViewState extends ConsumerState<SaveResultView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final titleController = useTextEditingController();
    final isSaveButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isSaveButtonEnabled.value = titleController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      return () {
        titleController.removeListener(listener);
      };
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.saveResult,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: isSaveButtonEnabled.value
                ? () async {
                    // get the user id first
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final title = titleController.text;
                    final isUploaded = await ref
                        .read(resultUploaderProvider.notifier)
                        .uploadResult(
                          file: widget.fileToPost,
                          fileType: widget.fileType,
                          title: title,
                          userId: userId,
                          categories: widget.categories,
                        );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                      CherryToast.success(
                              title: const Text(Strings.resultSaved))
                          .show(context);
                    }
                  }
                : null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // thumbnail
            FileThumbnailView(
              thumbnailRequest: thumbnailRequest,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteResultTitle,
                ),
                autofocus: true,
                maxLines: null,
                controller: titleController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
