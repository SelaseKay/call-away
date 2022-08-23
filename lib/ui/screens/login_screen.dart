import 'package:call_away/ui/components/brand_logo.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/signing_button.dart';
import 'package:call_away/ui/components/text_span.dart';
import 'package:call_away/ui/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
                    "Login",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 48.0),
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
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SignButton(text: "Login", onPressed: (){
                      
                    }),
                  ),

                   Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: 
                    CustomTextSpan(onTapText: (){
                       Navigator.push(
                    context,
                    PageRouteBuilder(
                      // transitionDuration:
                      //     const Duration(milliseconds: 550),
                      pageBuilder: (context, animation, secondaryAnimatio) =>
                          SignUpScreen(),
                    ));
                    }, unclickableText: "Don't have an account? ", clickableText: "Sign Up")
                  ),
              ],
            )
          ],
        )),
      ),
    );
  }
}