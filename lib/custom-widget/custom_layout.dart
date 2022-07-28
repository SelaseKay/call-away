import 'package:call_away/custom-widget/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout(
      {Key? key,
      required this.children,
      this.lightShadeBgColor = const Color(0xFFCCB2A9),
      this.darkShadeBgColor = const Color(0xFFA1887F),
      required this.topLeftSvg})
      : super(key: key);

  
  final Color lightShadeBgColor;
  final Color darkShadeBgColor;

  final List<Widget> children;
  final String topLeftSvg;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
      child: CustomPaint(
        painter: BackgroundPainter(
          lightShade: lightShadeBgColor,
          darkShade: darkShadeBgColor
        ),
        child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopSection(
                  topLeftSvg: topLeftSvg,
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      color: Colors.white),
                  child: ListView(
                    children: children,
                  ),
                )),
              ],
            )),
      ),
    ));
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({Key? key, required this.topLeftSvg}) : super(key: key);

  final String topLeftSvg;

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
                  topLeftSvg,
                  height: 72.0,
                  width: 80.0,
                ),
                topLeftSvg == "assets/images/contact-us.svg"
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("call",
                                style: GoogleFonts.mochiyPopPOne(
                                    fontSize: 16.0,
                                    color: const Color(0xFFDA7B23))),
                            const SizedBox(
                              height: 4,
                            ),
                            Text("AWAY",
                                style: GoogleFonts.mochiyPopPOne(
                                    fontSize: 20.0,
                                    color: const Color(0xFF373430)))
                          ],
                        ),
                      )
                    : const SizedBox.shrink()
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

// class _SubmitButton extends StatelessWidget {
//   const _SubmitButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return    Container(
//       color: Colors.white,
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 32.0, bottom: 24.0),
//               child: SizedBox(
//                 height: 48.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: const Color(0xFF039BE5),
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(8.0))
//                     )
//                   ),
//                   onPressed: (){}, 
//                   child: Text("Submit Report", style: GoogleFonts.prompt(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w800
//                   ),)),
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }