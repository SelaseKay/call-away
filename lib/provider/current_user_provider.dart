import 'package:call_away/model/user.dart';
import 'package:call_away/provider/user_auth_state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StreamProvider.autoDispose<UserModel>((ref) async* {
  final userStream = ref.watch(userStreamProvider);

  final user = userStream.value;

  if (user != null) {
    final userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .snapshots();

    await for (final value in userStream) {
      print('Stream value: $value');
      final currentUser = UserModel.fromJson(value.data()!);
      yield currentUser;
    }
  }
});
