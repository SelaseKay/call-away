import 'package:call_away/provider/auth_provider.dart';
import 'package:call_away/services/auth_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/overlay_loading_screen.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AuthenticationStateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password Updated Successfully")));
        Navigator.pop(context);
      } else if (next is AuthenticationStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
      } else if (next is AuthenticationStateLoading) {
        FocusScope.of(context).unfocus();
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFA1887F),
          textTheme: const TextTheme(
              headline6: TextStyle(color: Color(0xFFA1887F)),
              subtitle1: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF252525),
              ),
              subtitle2: TextStyle(color: Color(0xFF999999)),
              bodyText1: TextStyle(color: Color(0xFFD9D9D9)))),
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: AppBarSection(
                        title: "Change Password",
                        action: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    24,
                                  ),
                                ),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFDA7B23),
                                width: 1,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final currentPassword =
                                    _currentPasswordController.text.trim();
                                final newPassword =
                                    _newPasswordController.text.trim();

                                await ref
                                    .read(authProvider.notifier)
                                    .changePassword(
                                        currentPassword, newPassword);
                              }
                            },
                            child: Text(
                              "Save",
                              style: GoogleFonts.prompt(
                                textStyle: const TextStyle(
                                  color: Color(0xFFDA7B23),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            LabeledTextField(
                              label: "Current Password",
                              isPasswordField: true,
                              controller: _currentPasswordController,
                              validator: (value) =>
                                  Validator.validateCurrentPassword(value!),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            LabeledTextField(
                              label: "New Password",
                              isPasswordField: true,
                              validator: (value) =>
                                  Validator.validateNewPassword(value!),
                              controller: _newPasswordController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            LabeledTextField(
                              label: "Confirm Password",
                              isPasswordField: true,
                              validator: (value) =>
                                  Validator.validateConfirmPassword(value!,
                                      _newPasswordController.text.trim()),
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            authState is AuthenticationStateLoading
                ? const OverlayLoadingScreen()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
