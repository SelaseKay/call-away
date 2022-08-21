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

  Authentication copyWith({String? signUpMessage, String? loginMessage, bool? isLoginLoading, bool? isSignUpLoading}){
    return Authentication(
      signUpMessage: signUpMessage ?? this.signUpMessage,
      loginMessage: loginMessage?? this.loginMessage,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isSignUpLoading: isSignUpLoading ?? this.isSignUpLoading
    );
  }
}
