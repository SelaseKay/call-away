import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextSpan extends StatelessWidget {
  const CustomTextSpan(
      {Key? key,
      required this.onTapText,
      required this.clickableText,
      required this.unclickableText})
      : super(key: key);

  final VoidCallback onTapText;

  final String unclickableText;
  final String clickableText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: unclickableText,
            style: GoogleFonts.prompt(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.black)),
        TextSpan(
            text: clickableText,
            style: GoogleFonts.prompt(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFCE7A63)),
            recognizer: TapGestureRecognizer()..onTap = onTapText),
      ]),
      textAlign: TextAlign.center,
    );
  }
}
