import 'package:call_away/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StreamProvider<Stream<UserModel>>((ref) async* {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final stream =
      FirebaseFirestore.instance.collection("users").doc(userId).snapshots();

  await for (final value in stream) {
    print('Stream value: $value');
    // final user = UserModel.fromJson(value.data()!);
    // yield user;
  }
});
