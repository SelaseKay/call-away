import 'package:call_away/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthenticationState {}

class AuthenticationStateError extends AuthenticationState {
  AuthenticationStateError(this.errorMessage);

  final String errorMessage;
}

class AuthenticationStateSuccess extends AuthenticationState {
  AuthenticationStateSuccess(this.successMessage);

  final String successMessage;
}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateUserVerified extends AuthenticationState {}

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this.auth) : super(AuthenticationStateSuccess(""));

  final FirebaseAuth auth;

  Future<void> signUpUser(UserModel userModel) async {
    try {
      state = AuthenticationStateLoading();
      var credentials = await auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      User user = credentials.user!;
      // FirebaseFirestore.instance.collection("Users").doc(user.uid);
      
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(userModel.toJson());
      state = AuthenticationStateSuccess("Account created successfully");
      print(
          'succes message: ${(state as AuthenticationStateSuccess).successMessage}');
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

      if (userDoc["phoneVerifiedAt"] != null) {
        state = AuthenticationStateUserVerified();
      } else {
        state = AuthenticationStateError("User is not verified");
      }

      state = AuthenticationStateSuccess("Login successful");
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "Login message: ${(state as AuthenticationStateError).errorMessage}");
      return Future.error(e.message!);
    }
  }

  Future<void> logoutUser() async {
    try {
      state = AuthenticationStateLoading();
      await auth.signOut();
      state = AuthenticationStateSuccess("User signed out successfully");
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "Logout message: ${(state as AuthenticationStateError).errorMessage}");
    }
  }
}
