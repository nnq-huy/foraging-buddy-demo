import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/views/components/post/post_date_view.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/post_details/post_details_view.dart';

class PostsListView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsListView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    final listviewHeight = 0.6 * MediaQuery.of(context).size.height;
    return SizedBox(
      height: listviewHeight,
      child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts.elementAt(index);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostDetailsView(
                      post: post,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  shape: const StadiumBorder(
                      side: BorderSide(
                    color: AppColors.lightGrey,
                  )),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.thumbnailUrl)),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      post.message,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostDateView(
                        isSmall: true,
                        dateTime: post.createdAt,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            post.location!,
                            style: const TextStyle(
                                fontSize: 10, fontStyle: FontStyle.italic),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
