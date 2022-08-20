import 'package:call_away/model/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<Authentication> {
  AuthNotifier() : super(Authentication());

  final _auth = FirebaseAuth.instance;

  Future<void> signUpUser(
      String username, String email, String password) async {
    try {
      state = Authentication(isSignUpLoading: true);
      var credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = credentials.user!;
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
        "username": username,
        "email": email,
        "phone_number": null,
        "phone_verfied_at": null,
        "otp": null
      });
      state = Authentication(
          isSignUpLoading: false,
          signUpMessage: "Account created successfully");
      print(state.signUpMessage);
    } on FirebaseAuthException catch (e) {
      state = Authentication(
          isSignUpLoading: false,
          signUpMessage: "${e.message}");
      print("SignUpMessage: ${state.signUpMessage}");
    }
  }
}
