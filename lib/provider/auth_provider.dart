import 'package:call_away/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>((ref) {
  return AuthNotifier(FirebaseAuth.instance);
});
