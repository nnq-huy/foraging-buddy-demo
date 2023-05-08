import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:foraging_buddy/state/image_upload/helpers/image_picker_helper.dart';
import 'package:foraging_buddy/state/image_upload/models/file_type.dart';
import 'package:foraging_buddy/state/image_upload/providers/image_uploader_provider.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/identifier/mushroom_photo_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  const CreateNewPostView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  //final Future<File> fileToPostF = getImageFileFromAssets('img/place_holder.png');
  File? fileT;
  @override
  Widget build(BuildContext context) {
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewPost,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    //get the user id first
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded =
                        await ref.read(imageUploaderProvider.notifier).upload(
                              file: fileT!,
                              fileType: FileType.image,
                              message: message,
                              userId: userId,
                            );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                      CherryToast.success(
                              title: const Text(Strings.postCreated))
                          .show(context);
                    }
                  }
                : null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // thumbnail
            GestureDetector(
              onTap: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                setState(() {
                  fileT = imageFile;
                });
                // go to the screen to create a new post
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MushroomPhotoView(
                  file: fileT,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: Strings.writePostTitle,
                ),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
