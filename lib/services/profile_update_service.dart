import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ProfileUpdateState {}

class ProfileUpdateStateInitial extends ProfileUpdateState {}

class ProfileUpdateStateLoading extends ProfileUpdateState {}

class ProfileUpdateStateSuccess extends ProfileUpdateState {
  ProfileUpdateStateSuccess(this.successMessage);

  final String successMessage;
}

class ProfileUpdateStateError extends ProfileUpdateState {
  ProfileUpdateStateError(this.errorMessage);

  final String errorMessage;
}

class ProfileUpdateService extends StateNotifier<ProfileUpdateState> {
  ProfileUpdateService() : super(ProfileUpdateStateInitial());

  Future<void> updateUserNameEmail(String username, String email) async {
    state = ProfileUpdateStateLoading();

    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.updateEmail(email);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        "username": username,
      });
      state = ProfileUpdateStateSuccess("Profile Updated");
    } on FirebaseAuthException catch (e) {
      state = ProfileUpdateStateError(e.message!);
      return Future.error(e.message!);
    }
  }
}
