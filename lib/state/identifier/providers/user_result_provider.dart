import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:foraging_buddy/state/constants/firebase_collection_name.dart';
import 'package:foraging_buddy/state/constants/firebase_field_name.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/state/identifier/models/result_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userResultsProvider = StreamProvider.autoDispose<Iterable<Result>>((ref) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Result>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.results)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .where(
        ResultKey.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen((snapshot) {
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
        );
    controller.sink.add(results);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
