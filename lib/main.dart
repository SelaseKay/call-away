import 'package:call_away/model/user.dart';
import 'package:call_away/provider/login_state_provider.dart';
import 'package:call_away/ui/screens/add_phone_number_screen.dart';
import 'package:call_away/ui/screens/home_screen.dart';
import 'package:call_away/ui/screens/login_screen.dart';
import 'package:call_away/ui/screens/otp_verification-screen.dart';
import 'package:call_away/ui/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

enum UserState {
  verified,
  notVerified,
  notSignedUp,
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserState _userState = UserState.notSignedUp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserState();
    });
  }

  _checkUserState() async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        final usr = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        final userModel = UserModel.fromJson(usr.data()!);

        if (userModel.phoneVerifiedAt.isNotEmpty) {
          setState(() {
            _userState = UserState.verified;
          });
        } else {
          setState(() {
            _userState = UserState.notVerified;
          });
        }
        print("User state is: ${_userState.name}");
        // ref.read(loginStateProvider.notifier).state = true;
        print("User: ${user.email}");
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => _userState == UserState.verified
            ? const HomeScreen(
                title: "Call Away",
              )
            : LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/addPhoneNumber': (context) => AddPhoneNumberScreen(),
        '/addPhoneNumber/verifyOtp': (context) => OtpVerificationScreen(),
        '/home': (context) => const HomeScreen(title: "Call Away"),
      },
      theme: ThemeData(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
    );
  }
}
