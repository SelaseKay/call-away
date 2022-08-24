import 'package:call_away/ui/components/brand_logo.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/signing_button.dart';
import 'package:call_away/ui/components/text_span.dart';
import 'package:call_away/services/auth_service.dart';
import 'package:call_away/provider/auth_provider.dart';
import 'package:call_away/provider/form_key_provider.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthenticationState authState = ref.watch(authProvider);

    var formKey = ref.watch(formKeyProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AuthenticationStateSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.successMessage)));
        Navigator.pushNamedAndRemoveUntil(
            context, '/addPhoneNumber', (route) => false);
      } else if (next is AuthenticationStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
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
                  key: formKey,
                  child: Column(
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
                            hintText: "Jon Doe",
                            validator: (value) =>
                                Validator.validateUsername(value!),
                            controller: _userNameController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: LabeledTextField(
                            label: "Email",
                            hintText: "jondoe@gmail.com",
                            validator: (value) =>
                                Validator.validateEmail(value!),
                            controller: _emailController,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: LabeledTextField(
                            label: "Password",
                            isPasswordField: true,
                            validator: (value) =>
                                Validator.validatePassword(value!),
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
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ref
                                    .read(authProvider.notifier)
                                    .signUpUser(
                                        _userNameController.text.trim(),
                                        _emailController.text.trim(),
                                        _passwordController.text.trim());

                                // var state =
                                //     ref.read(authProvider.notifier).state;

                                // if (state is AuthenticationStateError) {
                                //   print(
                                //       "An error occured: ${(state).errorMessage}");
                                // } else if (state
                                //     is AuthenticationStateSuccess) {
                                //   Navigator.pushNamed(
                                //       context, '/addPhoneNumber');
                                //   // Navigator.pop(context);
                                //   print(
                                //       "Success message: ${(state).successMessage}");
                                // }

                                // print(
                                //     "current state is ${ref.read(authProvider.notifier).state}");

                                // print(
                                //     "Error occured while signing up: ${(authNotifier).successMessage}");

                              }
                            }),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: CustomTextSpan(
                              onTapText: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
                              },
                              clickableText: "Login",
                              unclickableText: "Already have an account? ")),
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
