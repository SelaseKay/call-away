import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String signUpMessage = "";
  String loginMessage = "";

  bool isSignUpLoading = false;
  bool isLoginLoading = false;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signUpUser(
      String username, String email, String password) async {
    try {
      isSignUpLoading = true;
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
      isSignUpLoading = false;
      signUpMessage = "Account created successfully";
      print(signUpMessage);
    } on FirebaseAuthException catch (e) {
      signUpMessage = e.message!;
      isSignUpLoading = false;
      print("SignUpMessage: $signUpMessage");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoginLoading = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoginLoading = false;
    } on FirebaseAuthException catch (e) {
      loginMessage = e.message!;
      isLoginLoading = false;
      print("Login message: $loginMessage");
    }
  }
}
