import 'package:call_away/services/otp_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpProvider = StateNotifierProvider<OtpService, OtpState>((ref) {
  return OtpService(Dio());
});
