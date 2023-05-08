import 'package:flutter/material.dart';
import 'package:foraging_buddy/extensions/date_formater.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/post_details/post_details_view.dart';

class PostMapPinPillComponent extends StatefulWidget {
  final double pinPillPosition;
  final Post? currentlySelectedPost;

  const PostMapPinPillComponent(
      {super.key, required this.pinPillPosition, this.currentlySelectedPost});

  @override
  State<StatefulWidget> createState() => PostMapPinPillComponentState();
}

class PostMapPinPillComponentState extends State<PostMapPinPillComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 60, 60),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 10),
                child: ClipOval(
                    child: Image.network(
                        widget.currentlySelectedPost!.thumbnailUrl,
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.currentlySelectedPost!.message,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.mapBold,
                      ),
                      Text(
                        dateFormatter(
                          widget.currentlySelectedPost!.createdAt,
                        ),
                        style: AppTextStyles.mapSmall,
                      ),
                      Text(
                        '${widget.currentlySelectedPost!.location}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailsView(
                          post: widget.currentlySelectedPost!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
