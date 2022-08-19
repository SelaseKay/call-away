import 'package:call_away/components/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
      child: Scaffold(
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: BrandLogo(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: _LabeledTextField(label: "Username")),
                const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: _LabeledTextField(label: "Email")),
                const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: _LabeledTextField(
                      label: "Password",
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true})
      : super(key: key);

  final String label;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.prompt(
                fontSize: 14.0, color: const Color(0xFF8A8A8A))),
        const SizedBox(
          height: 4.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
            ),

            // hintText: 'Mobile Number',
          ),
          obscureText: obscureText,
          enableSuggestions: enableSuggestions,
          autocorrect: autocorrect,

          style: const TextStyle(
            color: Colors.black
          ),
          
        )
      ],
    );
  }
}
