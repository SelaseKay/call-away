import 'package:call_away/components/brand_logo.dart';
import 'package:call_away/components/labeled_textfield.dart';
import 'package:call_away/components/signing_button.dart';
import 'package:call_away/components/text_span.dart';
import 'package:call_away/screens/add_phone_number_screen.dart';
import 'package:call_away/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: LabeledTextField(
                      label: "Username",
                      controller: _userNameController,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: LabeledTextField(
                      label: "Email",
                      controller: _emailController,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: LabeledTextField(
                      label: "Password",
                      isPasswordField: true,
                      controller: _passwordController,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CustomTextSpan(
                      onTapText: () {
                        //navigate to terms and coditions page
                      },
                      unclickableText: "By continuing, you agree to our",
                      clickableText: "\nTerms and Conditions",
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SignButton(
                      text: "Sign Up",
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              // transitionDuration:
                              //     const Duration(milliseconds: 550),
                              pageBuilder:
                                  (context, animation, secondaryAnimatio) =>
                                      const AddPhoneNumberScreen(),
                            ));
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: CustomTextSpan(
                        onTapText: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                // transitionDuration:
                                //     const Duration(milliseconds: 550),
                                pageBuilder:
                                    (context, animation, secondaryAnimatio) =>
                                        LoginScreen(),
                              ));
                        },
                        clickableText: "Login",
                        unclickableText: "Already have an account? ")),
              ],
            )
          ],
        )),
      ),
    );
  }
}
