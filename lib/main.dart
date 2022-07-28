import 'package:call_away/custom-widget/background.dart';
import 'package:call_away/custom-widget/custom_layout.dart';
import 'package:call_away/problem_type.dart';
import 'package:call_away/screens/problems_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
                            MaterialPageRoute(
                                builder: (context) =>  ProblemsScreen(
                                  topLeftSvg: "assets/images/pipeline.svg",
                                  problemType: ProblemType.WaterProblem,
                                  themeData: ThemeData(
                                    primaryColor: const Color(0xFF039BE5),
                                    primaryColorLight: Color(0xFF6EBCE4)
                                )),
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
                            MaterialPageRoute(
                                builder: (context) =>  ProblemsScreen(
                                  problemType: ProblemType.Others,
                                  pageHeading: "Others",
                                  topLeftSvg: "assets/images/others.svg",
                                  themeData: ThemeData(
                                    primaryColor: const Color(0xFF654A69),
                                    primaryColorLight: const Color(0xFF654A69).withOpacity(0.45)
                                )),
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
                            MaterialPageRoute(
                                builder: (context) =>  ProblemsScreen(
                                  problemType: ProblemType.ElectricityProblem,
                                  pageHeading: "Electricity Problem",
                                  topLeftSvg: "assets/images/electrician.svg",
                                  themeData: ThemeData(
                                    primaryColor: const Color(0xFF26A69A),
                                    primaryColorLight: const Color(0xFF26A69A).withOpacity(0.45)
                                )),
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
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // return Scaffold(
    //     body: SafeArea(
    //   child: CustomPaint(
    //     painter: BackgroundPainter(),
    //     child: SizedBox(
    //         height: screenHeight,
    //         width: screenWidth,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const _Brand(),
    //             Expanded(
    //                 child: Container(
    //               margin: const EdgeInsets.only(top: 12.0),
    //               padding:
    //                   const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
    //               decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(16.0),
    //                       topRight: Radius.circular(16.0)),
    //                   color: Colors.white),
    //               child: ListView(
    //                 children: [
    //                   const Padding(
    //                       padding: EdgeInsets.only(top: 32.0),
    //                       child: _Header()),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 24.0),
    //                     child: IntrinsicHeight(
    //                       child: Row(
    //                         children: [
    //                           Expanded(
    //                             child: Column(
    //                               children: const [
    //                                 _ProblemTypeButton(
    //                                     backgroundColor: Color(0xFF4FC3F7),
    //                                     assetName: "assets/images/pipeline.svg",
    //                                     buttonText: "Water Problem"),
    //                                 SizedBox(
    //                                   height: 20.0,
    //                                 ),
    //                                 _ProblemTypeButton(
    //                                     backgroundColor: Color(0xFF654A69),
    //                                     assetName: "assets/images/others.svg",
    //                                     buttonText: "Others")
    //                               ],
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             width: 8.0,
    //                           ),
    //                           const Expanded(
    //                             child: _ProblemTypeButton(
    //                                 backgroundColor: Color(0xFF6C6461),
    //                                 assetName: "assets/images/electrician.svg",
    //                                 buttonText: "Electricity Problem"),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ))
    //           ],
    //         )),
    //   ),
    // ));
  }
}

class _Brand extends StatelessWidget {
  const _Brand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/contact-us.svg",
                  height: 72.0,
                  width: 80.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("call",
                          style: GoogleFonts.mochiyPopPOne(
                              fontSize: 16.0, color: const Color(0xFFDA7B23))),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("AWAY",
                          style: GoogleFonts.mochiyPopPOne(
                              fontSize: 20.0, color: const Color(0xFF373430)))
                    ],
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: _IconButton(
                  assetName: 'assets/images/def_notif.svg',
                ),
              ),
              _IconButton(assetName: 'assets/images/profile.svg'),
            ],
          )
        ],
      ),
    );
  }
}

class _IconButton extends StatefulWidget {
  const _IconButton({Key? key, required this.assetName}) : super(key: key);
  final String assetName;

  @override
  State<_IconButton> createState() => __IconButtonState();
}

class __IconButtonState extends State<_IconButton> {
  @override
  Widget build(BuildContext context) {
    // return CircleAvatar(
    //   backgroundColor: const Color(0xFF000000).withOpacity(0.23),
    //   child: IconButton(
    //       color: Colors.black,
    //       iconSize: 24,
    //       icon: SvgPicture.asset('assets/images/def_notif.svg'),
    //       onPressed: () {
    //         // do something
    //       }),
    // );
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF000000).withOpacity(0.23),
        shape: const CircleBorder(),
        // shape: MaterialStateProperty.all(const CircleBorder()),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // padding: MaterialStateProperty.all(const EdgeInsets.all(2.0)),
        // backgroundColor: MaterialStateProperty.all(
        //     const Color(0xFF000000).withOpacity(0.23)), // <-- Button color
        // overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        //   if (states.contains(MaterialState.pressed))
        //     return Colors.red; // <-- Splash color
        // }),
      ),
      child: SvgPicture.asset(widget.assetName),
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
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/header.svg',
              height: 102.0,
              width: 102.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "What problem type",
                  style: TextStyle(
                      fontFamily: "MochiyPopPOne",
                      fontSize: 16.0,
                      color: Color(0xFF693F3F),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "would you like to",
                  style: GoogleFonts.mochiyPopPOne(
                      fontSize: 16.0,
                      color: const Color(0xFF693F3F),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "report",
                  style: GoogleFonts.mochiyPopPOne(
                      fontSize: 16.0,
                      color: const Color(0xFF693F3F),
                      fontWeight: FontWeight.bold),
                )
              ],
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
