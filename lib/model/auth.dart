import 'package:flutter/cupertino.dart';

@immutable
class Authentication {
  Authentication(
      {this.signUpMessage = "",
      this.loginMessage = "",
      this.isSignUpLoading = false,
      this.isLoginLoading = false});

  final String signUpMessage;
  String loginMessage;

  final bool isSignUpLoading;
  final bool isLoginLoading;
}
