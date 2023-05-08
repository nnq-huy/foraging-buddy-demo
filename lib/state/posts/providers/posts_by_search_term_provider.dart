import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/constants/firebase_collection_name.dart';
import 'package:foraging_buddy/state/constants/firebase_field_name.dart';
import 'package:foraging_buddy/state/posts/models/post.dart';
import 'package:foraging_buddy/state/posts/typedefs/search_term.dart';

final postsBySearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>(
  (ref, SearchTerm searchTerm) {
    final controller = StreamController<Iterable<Post>>();
    final userId = ref.watch(userIdProvider);

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .where('uid', isEqualTo: userId)
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final posts = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            )
            .where(
              (post) => post.message.toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  ),
            );
        controller.sink.add(posts);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
