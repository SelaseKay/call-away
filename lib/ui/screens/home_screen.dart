import 'package:call_away/background_task/callback_dispatcher.dart';
import 'package:call_away/problem_type.dart';
import 'package:call_away/provider/current_user_provider.dart';
import 'package:call_away/ui/custom-widget/custom_layout.dart';
import 'package:call_away/ui/screens/report_form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // final userId = FirebaseAuth.instance.currentUser!.uid;

    // try {
    //   FirebaseFirestore.instance
    //       .collection("reports")
    //       .where("userId", isEqualTo: userId)
    //       .snapshots()
    //       .listen((event) {
    //     print("Collection document has been modified");
    //     for (var change in event.docChanges) {
    //       if (change.type == DocumentChangeType.modified) {
    //         print("Report#${change.doc.id} status has changed.");
    //       }
    //     }
    //   });
    // } catch (e) {
    //   print("error: ${e.toString()}");
    // }

    setupWorkManager();

    //  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');

    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           "${message.notification!.body}",
    //           style: const TextStyle(
    //             fontSize: 14.0,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     );
    //     print('Message also contained a notification: ${message.notification!.body}');
    //   }
    // });
  }

  setupWorkManager() async {
    final user = FirebaseAuth.instance.currentUser;

    await Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        );

    await Workmanager().registerOneOffTask(
        "periodic-task-identifier", "simplePeriodicTask",
        tag: "notifications_manager",
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {'userId': user!.uid});
  }

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
                                  problemType: ProblemType.waterProblem,
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
                                  problemType: ProblemType.others,
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
                              problemType: ProblemType.electricityProblem,
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
