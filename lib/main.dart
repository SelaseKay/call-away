import 'package:call_away/provider/user_state_provider.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/screens/add_phone_number_screen.dart';
import 'package:call_away/ui/screens/home_screen.dart';
import 'package:call_away/ui/screens/login_screen.dart';
import 'package:call_away/ui/screens/otp_verification-screen.dart';
import 'package:call_away/ui/screens/profile_screen.dart';
import 'package:call_away/ui/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  void _handleMessage(RemoteMessage message) {
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat',
    //     arguments: ChatArguments(message),
    //   );
    // }
  }
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  


  @override
  void initState() {
    super.initState();
    // _checkUserState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider).value;

    return MaterialApp(
      title: 'Call Away',
      debugShowCheckedModeBanner: false,
      home: userState == null
          ? const LoadingScreen(loadingText: "")
          : (userState == UserState.verified
              ? const HomeScreen(title: "Call away")
              : const LoginScreen()),
      onGenerateRoute: (settings) => _generateRoute(settings),
      theme: ThemeData(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
    );
  }

  _generateRoute(settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    } else if (settings.name == 'home') {
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(
          title: "Call Away",
        ),
      );
    } else if (settings.name == '/signup') {
      return MaterialPageRoute(
        builder: (_) => SignUpScreen(),
      );
    } else if (settings.name == 'addPhoneNumber') {
      return MaterialPageRoute(
        builder: (_) => AddPhoneNumberScreen(),
      );
    } else if (settings.name == 'addPhoneNumber/verifyOtp') {
      final phoneNumber = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => OtpVerificationScreen(phoneNumber: phoneNumber),
      );
    } else if (settings.name == 'profile') {
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      );
    } else if (settings.name == 'loading') {
      return MaterialPageRoute(
        builder: (_) => const LoadingScreen(
          loadingText: "",
        ),
      );
    }
    return null;
  }
}
