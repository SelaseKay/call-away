import 'package:call_away/custom-widget/background.dart';
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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: CustomPaint(
        painter: BackgroundPainter(),
        child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const _Brand(),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                      color: Colors.white
                    ),
                    child: ListView(
                      children: [],
                    ),
                  ),
                ))
                ],
            )),
      ),
    ));
  }
}

class _Brand extends StatelessWidget {
  const _Brand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0, top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/contact-us.svg"),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("call",
                          style: GoogleFonts.mochiyPopOne(
                              fontSize: 16.0, color: const Color(0xFFDA7B23))),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("AWAY",
                          style: GoogleFonts.mochiyPopOne(
                              fontSize: 20.0, color: const Color(0xFF373430)))
                    ],
                  ),
                )
              ],
            ),
          ),
          const _NotificationIcon()
        ],
      ),
    );
  }
}

class _NotificationIcon extends StatefulWidget {
  const _NotificationIcon({Key? key}) : super(key: key);

  @override
  State<_NotificationIcon> createState() => __NotificationIconState();
}

class __NotificationIconState extends State<_NotificationIcon> {
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
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        // padding: MaterialStateProperty.all(const EdgeInsets.all(2.0)),
        backgroundColor:
            MaterialStateProperty.all(const Color(0xFF000000).withOpacity(0.23)), // <-- Button color
        // overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        //   if (states.contains(MaterialState.pressed))
        //     return Colors.red; // <-- Splash color
        // }),
      ),
      child: SvgPicture.asset('assets/images/def_notif.svg'),
    );
  }
}
