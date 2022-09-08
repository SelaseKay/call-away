import 'dart:io';

import 'package:call_away/model/user.dart';
import 'package:call_away/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserProfilePictureState {}

class UserProfilePictureStateInitial extends UserProfilePictureState {}

class UserProfilePictureStateLoading extends UserProfilePictureState {}

class UserProfilePictureStateSuccess extends UserProfilePictureState {
  UserProfilePictureStateSuccess(
      {this.successMessage = "", required this.user});

  final String successMessage;
  final UserModel user;
}

class UserProfilePictureStateError extends UserProfilePictureState {
  UserProfilePictureStateError(this.errorMessage);
  final String errorMessage;
}

class UserPictureUpdateService extends StateNotifier<UserProfilePictureState> {
  UserPictureUpdateService(this.ref) : super(UserProfilePictureStateInitial());

  final StateNotifierProviderRef<UserPictureUpdateService,
      UserProfilePictureState> ref;

  Future<void> updateProfilePic(XFile? image) async {
    state = UserProfilePictureStateLoading();

    final storageRef = FirebaseStorage.instance.ref();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final profilePicRef = storageRef.child("profile$userId.jpg");

    await profilePicRef.putFile(File(image!.path));

    final profilePicUrl = await profilePicRef.getDownloadURL();

    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "profilePicUrl": profilePicUrl,
    }).then((value) async {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      final user = UserModel.fromJson(userDoc.data()!);
      print("User model: $user");
      state = UserProfilePictureStateSuccess(
          successMessage: "Profile picture updated.", user: user);
      await ref.read(authProvider.notifier).getCurrentUserModel();
    }).catchError((e) {
      state = UserProfilePictureStateError(e.toString());
    });
  }
}
