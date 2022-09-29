import 'package:call_away/model/user.dart';
import 'package:call_away/provider/user_auth_state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

final currentUserProvider = StreamProvider.autoDispose<UserModel>((ref) async* {
  final userStream = ref.watch(userStreamProvider);

  final user = userStream.value;

  if (user != null) {
    final userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .snapshots();

    await for (final value in userStream) {
      final currentUser = UserModel.fromJson(value.data()!);
      if (currentUser.blocked) {
        await FirebaseAuth.instance.signOut();
        Workmanager().cancelByTag("notifications_manager");
      }
      yield currentUser;
    }
  }
});
