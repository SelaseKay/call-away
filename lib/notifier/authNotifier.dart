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

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this.auth) : super(AuthenticationStateSuccess(""));

  final FirebaseAuth auth;

  Future<void> signUpUser(
      String email, String password, String username) async {
    try {
      state = AuthenticationStateLoading();
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = credentials.user!;
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
        "username": username,
        "email": email,
        "phone_number": null,
        "phone_verfied_at": null,
        "otp": null
      });
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
      await auth.signInWithEmailAndPassword(email: email, password: password);
      state = AuthenticationStateSuccess("Login successful");
    } on FirebaseAuthException catch (e) {
      state = AuthenticationStateError(e.message!);
      print(
          "Login message: ${(state as AuthenticationStateError).errorMessage}");
    }
  }
}

// class AuthNotifier extends StateNotifier<Authentication> {
//   AuthNotifier() : super(Authentication());

//   final _auth = FirebaseAuth.instance;

//   final _authentication = Authentication();

//   Future<void> signUpUser(
//       String username, String email, String password) async {
//     try {
//       state = Authentication(isSignUpLoading: true);
//       var credentials = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User user = credentials.user!;
//       await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
//         "username": username,
//         "email": email,
//         "phone_number": null,
//         "phone_verfied_at": null,
//         "otp": null
//       });
//       state = Authentication(
//           isSignUpLoading: false,
//           signUpMessage: "Account created successfully");
//       print(state.signUpMessage);
//     } on FirebaseAuthException catch (e) {
//       state =
//           Authentication(isSignUpLoading: false, signUpMessage: "${e.message}");
//       print("SignUpMessage: ${state.signUpMessage}");
//     }
//   }
// }
