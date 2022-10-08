import 'package:call_away/provider/user_state_provider.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/screens/add_phone_number_screen.dart';
import 'package:call_away/ui/screens/home_screen.dart';
import 'package:call_away/ui/screens/login_screen.dart';
import 'package:call_away/ui/screens/otp_verification-screen.dart';
import 'package:call_away/ui/screens/profile_screen.dart';
import 'package:call_away/ui/screens/report_form_screen.dart';
import 'package:call_away/ui/screens/sign_up_screen.dart';
import 'package:call_away/ui/screens/video_screen.dart';
import 'package:camera/camera.dart';
import 'package:call_away/ui/screens/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
      // home: ReportFormScreen(),
      home: userState == null
          ? const LoadingScreen(loadingText: "")
          : (userState == UserState.verified
              ? const HomeScreen(title: "Call away")
              : const LoginScreen()),
      onGenerateRoute: (settings) => _generateRoute(settings),
      theme: ThemeData(
        primaryColor: const Color(0xFFCE7A63),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xFFA1887F),
          ),
        ),
      ),
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
    } else if (settings.name == 'terms_and_conditions') {
      return MaterialPageRoute(
        builder: (_) => const TermsAndConditionsScreen(),
      );
    }
    else if (settings.name == 'loading') {
      return MaterialPageRoute(
        builder: (_) => const LoadingScreen(
          loadingText: "",
        ),
      );
    } else if (settings.name == 'video_screen') {
      return MaterialPageRoute(
        builder: (_) => VideoScreen(
          cameras: cameras,
        ),
      );
    } else if (settings.name == 'report_form_screen') {
      return MaterialPageRoute(builder: (_) => ReportFormScreen());
    }
    return null;
  }
}
