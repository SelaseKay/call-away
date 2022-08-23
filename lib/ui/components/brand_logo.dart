import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
