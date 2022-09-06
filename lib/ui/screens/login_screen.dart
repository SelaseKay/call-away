import 'package:call_away/provider/auth_provider.dart';
import 'package:call_away/services/auth_service.dart';
import 'package:call_away/ui/components/brand_logo.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/signing_button.dart';
import 'package:call_away/ui/components/text_span.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AuthenticationStateSuccess && next.isUserVerified) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (route) => false,
        );
      } else if (next is AuthenticationStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
        if (next.errorMessage == "User is not verified") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/addPhoneNumber",
            (route) => false,
          );
        }
      } else if (next is AuthenticationStateLoading) {
        FocusScope.of(context).unfocus();
      }
    });
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFCE7A63),
          textTheme:
              const TextTheme(headline6: TextStyle(color: Color(0xFFA1887F)))),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: BrandLogo(),
                ),
                Form(
                  key: _formKey,
                  child: Column(
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
                            keyboardType: TextInputType.emailAddress,
                            hintText: "jondoe@gmail.com",
                            validator: (value) =>
                                Validator.validateEmail(value!),
                            controller: _emailController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: LabeledTextField(
                            label: "Password",
                            validator: (value) =>
                                Validator.validatePassword(value!),
                            isPasswordField: true,
                            controller: _passwordController,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: SignButton(
                            text: "Login",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref.read(authProvider.notifier).loginUser(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim());
                              }
                            }),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: CustomTextSpan(
                              onTapText: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/signUp", (route) => false);
                              },
                              unclickableText: "Don't have an account? ",
                              clickableText: "Sign Up")),
                    ],
                  ),
                )
              ],
            ),
            authState is AuthenticationStateLoading
                ? const LoadingScreen()
                : const SizedBox.shrink()
          ],
        )),
      ),
    );
  }
}
