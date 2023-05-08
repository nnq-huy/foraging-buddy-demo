import 'package:flutter/material.dart';
import 'package:foraging_buddy/views/components/image_view_with_aspect.dart';
import 'package:foraging_buddy/views/components/post/single_post_mapview.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/state/posts/providers/delete_post_provider.dart';
import 'package:foraging_buddy/views/components/dialogs/alert_dialog_model.dart';
import 'package:foraging_buddy/views/components/dialogs/delete_dialog.dart';
import 'package:foraging_buddy/views/components/post/post_date_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:cherry_toast/cherry_toast.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.postDetails,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post)
                    .present(context)
                    .then((shouldDelete) => shouldDelete ?? false);
                if (shouldDeletePost) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                    CherryToast.success(title: const Text(Strings.postDeleted))
                        .show(context);
                  }
                }
                // delete the post now
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageViewWithAspect(
                fileUrl: widget.post.fileUrl,
                aspectRatio: widget.post.aspectRatio,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.post.message,
                  style: AppTextStyles.mushroomBold,
                ),
              ),
              PostDateView(
                dateTime: widget.post.createdAt,
                isSmall: false,
              ),
              Text(widget.post.location!),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SinglePostMapView(
                        post: widget.post,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.location_searching),
                label: const Text(Strings.showOnMap),
              ),
            ],
          ),
        ));
  }
}
