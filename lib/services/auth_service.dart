import 'package:call_away/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthenticationState {}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateError extends AuthenticationState {
  AuthenticationStateError(this.errorMessage);

  final String errorMessage;
}

class AuthenticationStateSuccess extends AuthenticationState {
  AuthenticationStateSuccess({this.isUserVerified = false, this.user});

  final bool isUserVerified;
  final UserModel? user;
}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateUserVerified extends AuthenticationState {}

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this.auth) : super(AuthenticationStateInitial());

  final FirebaseAuth auth;

  Future<void> signUpUser(UserModel userModel) async {
    try {
      state = AuthenticationStateLoading();
      var credentials = await auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      User user = credentials.user!;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(userModel.copyWith(userId: user.uid).toJson());
      state = AuthenticationStateSuccess();
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "SignUpMessage: ${(state as AuthenticationStateError).errorMessage}");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      state = AuthenticationStateLoading();
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credentials.user;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();

      final userModel = UserModel.fromJson(userDoc.data()!);

      if (userModel.phoneVerifiedAt.isNotEmpty) {
        state = AuthenticationStateSuccess(isUserVerified: true);
      } else {
        state = AuthenticationStateError("User is not verified");
      }

      // state = AuthenticationStateSuccess("Login successful");
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "Login message: ${(state as AuthenticationStateError).errorMessage}");
      return Future.error(e.message!);
    }
  }

  // Future<void> getCurrentUserModel() async {
  //   print("getCurrentUserModel.....");
  //   state = AuthenticationStateLoading();

  //   final userId = FirebaseAuth.instance.currentUser!.uid;

  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .get()
  //       .then((value) {
  //     final userModel = UserModel.fromJson(value.data()!);

  //     state = AuthenticationStateSuccess(isUserVerified: true, user: userModel);
  //   }).catchError((e) {
  //     state = AuthenticationStateError(e.toString());
  //   });
  // }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    state = AuthenticationStateLoading();

    final user = FirebaseAuth.instance.currentUser;

    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    final userModel = UserModel.fromJson(userDoc.data()!);

    final cred = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        state =
            AuthenticationStateSuccess(isUserVerified: true, user: userModel);
      }).catchError((error) {
        //Error, show something
        state = AuthenticationStateError(error.toString());
      });
    }).catchError((error) {
      state = AuthenticationStateError(error.toString());
    });
  }

  Future<void> logoutUser() async {
    try {
      state = AuthenticationStateLoading();
      await auth.signOut();
      state = AuthenticationStateSuccess();
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "Logout message: ${(state as AuthenticationStateError).errorMessage}");
    }
  }
}
