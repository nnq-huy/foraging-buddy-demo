import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foraging_buddy/state/constants/firebase_collection_name.dart';
import 'package:foraging_buddy/state/constants/firebase_field_name.dart';
import 'package:foraging_buddy/state/posts/typedefs/search_term.dart';

final resultsBySearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Result>, SearchTerm>(
  (ref, SearchTerm searchTerm) {
    final controller = StreamController<Iterable<Result>>();
    final userId = ref.watch(userIdProvider);

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.results,
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

        final results = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Result.fromJson(
                doc.data(),
                doc.id,
              ),
            )
            .where(
              (post) => post.title.toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  ),
            );
        controller.sink.add(results);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
