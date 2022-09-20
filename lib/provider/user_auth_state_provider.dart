import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose<User?>((ref) async* {
  final stream = FirebaseAuth.instance.authStateChanges();

  await for (final value in stream) {
    print("User is: $value");
    // if (value == null) {
    //   continue;
    // }
    yield value;
  }
});
