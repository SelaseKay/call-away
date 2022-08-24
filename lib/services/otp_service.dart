import 'dart:convert';
import 'dart:math';

import 'package:call_away/my_env.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OtpState {}

class OtpStateInitial extends OtpState {}

class OtpStateSuccess extends OtpState {
  OtpStateSuccess({this.otpCode = ""});

  final String otpCode;
}

class OtpStateError extends OtpState {
  OtpStateError(this.errorMessage);

  final String errorMessage;
}

class OtpStateLoading extends OtpState {}

class OtpService extends StateNotifier<OtpState> {
  OtpService(this.dio) : super(OtpStateInitial());

  final Dio dio;

  var _otpCode = "";

  Future<void> sendOtpCode(String phoneNumber) async {
    _otpCode = _generateOtpCode();
    var params = {
      "skey": sKey,
      "ckey": cKey,
      "recip": phoneNumber,
      "sender_id": "Call Away",
      "smsbody": "Your OTP code is: $_otpCode"
    };

    try {
      state = OtpStateLoading();
      await dio.post("https://sms-api.draytechits.com/send_api_sms",
          data: jsonEncode(params));
      state = OtpStateSuccess(otpCode: _otpCode);
    } on DioError catch (e) {
      state = OtpStateError(e.message);
    }
  }

  Future<void> verifiyUserOtp(String userOtp) async {
    if (userOtp == _otpCode) {
      final user = FirebaseAuth.instance.currentUser;

      try {
        state = OtpStateLoading();
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user!.uid)
            .update({"phone_verified_at": Timestamp.now().toString()});
        state = OtpStateSuccess();
      } on FirebaseAuthException catch (e) {
        state = OtpStateError(e.message!);
        return Future.error(e.message!);
      }
    } else {
      state = OtpStateError("Code entered does not match code sent via sms");
      return Future.error("Code entered does not match code sent via sms");
    }
  }

  String _generateOtpCode() {
    final rand = Random();
    String otp = "";
    for (int i = 0; i < 4; i++) {
      otp = otp + rand.nextInt(10).toString();
    }
    return otp;
  }
}
