import 'package:call_away/model/user.dart';
import 'package:call_away/provider/user_auth_state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserState {
  verified,
  notVerified,
  notSignedUp,
}

final userStateProvider = FutureProvider.autoDispose<UserState>((ref) async {
  final userStream = ref.watch(userStreamProvider);

  final user = userStream.value;
  UserState userState = UserState.notSignedUp;

  print("User is: $user");

  if (user != null) {
    final usr = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    final userModel = UserModel.fromJson(usr.data()!);

    if (userModel.phoneVerifiedAt.isNotEmpty) {
      userState = UserState.verified;
    } else {
      userState = UserState.notVerified;
    }
    print("User state is: ${userState.name}");
    // ref.read(loginStateProvider.notifier).state = true;
    print("User: ${user.email}");
  }

  return userState;
});
