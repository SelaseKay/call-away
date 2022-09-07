import 'dart:io';

import 'package:call_away/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileUpdateState {}

class ProfileUpdateStateInitial extends ProfileUpdateState {}

class ProfileUpdateStateLoading extends ProfileUpdateState {}

class ProfileUpdateStateSuccess extends ProfileUpdateState {
  ProfileUpdateStateSuccess({required this.successMessage, required this.user});

  final String successMessage;
  final UserModel user;
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
        "email": email,
      });
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      state = ProfileUpdateStateSuccess(
          successMessage: "Profile Updated",
          user: UserModel.fromJson(userDoc.data()!));
    } on FirebaseAuthException catch (e) {
      state = ProfileUpdateStateError(e.message!);
      return Future.error(e.message!);
    }
  }

  Future<void> updateProfilePic(XFile? image) async {
    state = ProfileUpdateStateLoading();

    final storageRef = FirebaseStorage.instance.ref();

    final profilePicRef = storageRef.child(image!.name);

    await profilePicRef.putFile(File(image.path));

    final profilePicUrl = await profilePicRef.getDownloadURL();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "profilePicUrl": profilePicUrl,
    }).then((value) async {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      state = ProfileUpdateStateSuccess(
          successMessage: "Profile picture updated.",
          user: UserModel.fromJson(userDoc.data()!));
    }).catchError((e) {
      state = ProfileUpdateStateError(e.toString());
    });
  }
}
