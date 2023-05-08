import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/state/identifier/providers/delete_result_provider.dart';
import 'package:foraging_buddy/views/components/dialogs/alert_dialog_model.dart';
import 'package:foraging_buddy/views/components/dialogs/delete_dialog.dart';
import 'package:foraging_buddy/views/components/post/post_date_view.dart';
import 'package:foraging_buddy/views/components/image_view_with_aspect.dart';
import 'package:foraging_buddy/views/components/result/result_labels_view.dart';
import 'package:foraging_buddy/views/components/result/single_result_map_view.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/views/constants/strings.dart';

class ResultDetailsView extends ConsumerStatefulWidget {
  final Result result;
  const ResultDetailsView({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResultDetailsViewState();
}

class _ResultDetailsViewState extends ConsumerState<ResultDetailsView> {
  @override
  Widget build(BuildContext context) {
    // get the actual post together with its comments
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.resultDetails,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final shouldDeleteResult = await const DeleteDialog(
                      titleOfObjectToDelete: Strings.result)
                  .present(context)
                  .then((shouldDelete) => shouldDelete ?? false);
              if (shouldDeleteResult) {
                await ref
                    .read(deleteResultrovider.notifier)
                    .deleteResult(result: widget.result);
                if (mounted) {
                  Navigator.of(context).pop();
                  CherryToast.success(title: const Text(Strings.resultDeleted))
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageViewWithAspect(
              fileUrl: widget.result.fileUrl,
              aspectRatio: widget.result.aspectRatio,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.result.title,
                style: AppTextStyles.mushroomBold,
              ),
            ),
            PostDateView(
              dateTime: widget.result.createdAt,
              isSmall: false,
            ),
            ResultLabelsView(result: widget.result),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleResultMapView(
                        result: widget.result,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.location_searching),
                label: const Text(Strings.showOnMap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
