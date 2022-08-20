// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAyWOM4aEAco4eJqzS0eLNKhn5PdM4VSxw',
    appId: '1:35696865082:web:d05fdf8eb2314f44e96a03',
    messagingSenderId: '35696865082',
    projectId: 'call-away-backend',
    authDomain: 'call-away-backend.firebaseapp.com',
    storageBucket: 'call-away-backend.appspot.com',
    measurementId: 'G-DLQGFDDZXW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAq0MGbUW_gamzsBOyh_BzWuqVgEhs7_SI',
    appId: '1:35696865082:android:be4cd6c1d0cef434e96a03',
    messagingSenderId: '35696865082',
    projectId: 'call-away-backend',
    storageBucket: 'call-away-backend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHlKywK_VH7ZmohBnyuPYgXLPI897kRts',
    appId: '1:35696865082:ios:47ae6bee9e74ef85e96a03',
    messagingSenderId: '35696865082',
    projectId: 'call-away-backend',
    storageBucket: 'call-away-backend.appspot.com',
    iosClientId: '35696865082-qpkl25v2utsldjm7komk58m0l1efdsg1.apps.googleusercontent.com',
    iosBundleId: 'com.example.callAway',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHlKywK_VH7ZmohBnyuPYgXLPI897kRts',
    appId: '1:35696865082:ios:47ae6bee9e74ef85e96a03',
    messagingSenderId: '35696865082',
    projectId: 'call-away-backend',
    storageBucket: 'call-away-backend.appspot.com',
    iosClientId: '35696865082-qpkl25v2utsldjm7komk58m0l1efdsg1.apps.googleusercontent.com',
    iosBundleId: 'com.example.callAway',
  );
}
