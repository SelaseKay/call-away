import 'package:call_away/custom-widget/custom_layout.dart';
import 'package:call_away/problem_type.dart';
import 'package:call_away/screens/report_form_screen.dart';
import 'package:call_away/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // firebaseApp.then((value) => const ProviderScope(child: MyApp())).catchError((e)=>debugPrint("An error occured: $e"));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
      home: SignUpScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      topLeftSvg: "assets/images/contact-us.svg",
      children: [
        const Padding(padding: EdgeInsets.only(top: 32.0), child: _Header()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _ProblemTypeButton(
                        backgroundColor: const Color(0xFF4FC3F7),
                        assetName: "assets/images/pipeline.svg",
                        buttonText: "Water Problem",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                // transitionDuration:
                                //     const Duration(milliseconds: 550),
                                pageBuilder:
                                    (context, animation, secondaryAnimatio) =>
                                        ReportFormScreen(
                                  topLeftSvg: "assets/images/pipeline.svg",
                                  problemType: ProblemType.WaterProblem,
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _ProblemTypeButton(
                        backgroundColor: const Color(0xFF654A69),
                        assetName: "assets/images/others.svg",
                        buttonText: "Others",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                // transitionDuration:
                                //     const Duration(milliseconds: 550),
                                pageBuilder:
                                    (context, animation, secondaryAnimatio) =>
                                        ReportFormScreen(
                                  problemType: ProblemType.Others,
                                  // pageHeading: "Others",
                                  topLeftSvg: "assets/images/others.svg",
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: _ProblemTypeButton(
                    backgroundColor: const Color(0xFF6C6461),
                    assetName: "assets/images/electrician.svg",
                    buttonText: "Electricity Problem",
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            // transitionDuration:
                            //     const Duration(milliseconds: 550),
                            pageBuilder:
                                (context, animation, secondaryAnimatio) =>
                                    ReportFormScreen(
                              problemType: ProblemType.ElectricityProblem,
                              // pageHeading: "Electricity Problem",
                              topLeftSvg: "assets/images/electrician.svg",
                            ),
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Color(0xFFD7CCC8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/header.svg',
              height: 102.0,
              width: 102.0,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "What problem type would you like to report?",
                    style: TextStyle(
                        fontFamily: "MochiyPopPOne",
                        fontSize: 16.0,
                        color: Color(0xFF693F3F),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProblemTypeButton extends StatelessWidget {
  const _ProblemTypeButton(
      {Key? key,
      required this.backgroundColor,
      required this.assetName,
      required this.onPressed,
      required this.buttonText})
      : super(key: key);

  final Color backgroundColor;
  final String assetName;
  final String buttonText;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 3.0,
            primary: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "MochiyPopPone",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SvgPicture.asset(
                assetName,
                height: 96.0,
                width: 96.0,
              )
            ],
          ),
        ));
  }
}
