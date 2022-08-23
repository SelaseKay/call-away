import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignButton extends StatelessWidget {
  const SignButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: const Color(0xFFCE7A63)),
            onPressed: onPressed,
            child: Text(
              text,
              style: GoogleFonts.prompt(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
      ],
    );
  }
}
