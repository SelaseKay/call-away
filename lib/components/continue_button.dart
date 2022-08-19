import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color(0xFFCE7A63)),
        onPressed: onPressed,
        child: Text(
          "Continue",
          style: GoogleFonts.prompt(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w500),
        ));
  }
}
