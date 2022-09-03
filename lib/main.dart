import 'package:call_away/ui/screens/add_phone_number_screen.dart';
import 'package:call_away/ui/screens/home_screen.dart';
import 'package:call_away/ui/screens/login_screen.dart';
import 'package:call_away/ui/screens/otp_verification-screen.dart';
import 'package:call_away/ui/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isUserLoggedIn = true;
        });
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
        '/': (context) => isUserLoggedIn
            ? const HomeScreen(title: "Call Away")
            : LoginScreen(),
        'login': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/addPhoneNumber': (context) => AddPhoneNumberScreen(),
        '/addPhoneNumber/verifyOtp': (context) => OtpVerificationScreen(),
        'home': (context) => const HomeScreen(title: "Call Away")
      },
      theme: ThemeData(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
    );
  }
}
