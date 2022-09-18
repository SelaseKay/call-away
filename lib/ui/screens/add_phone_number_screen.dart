import 'package:call_away/provider/otp_provider.dart';
import 'package:call_away/services/otp_service.dart';
import 'package:call_away/ui/components/continue_button.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/overlay_loading_screen.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPhoneNumberScreen extends ConsumerWidget {
  AddPhoneNumberScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpProvider);

    ref.listen<OtpState>(otpProvider, (previous, next) {
      if (next is OtpStateSuccess) {
        final phoneNumber = _controller.text.trim();
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimatio) =>
        //         OtpVerificationScreen(
        //       phoneNumber: _controller.text.trim(),
        //     ),
        //   ),
        // );
        Navigator.pushNamedAndRemoveUntil(
            context, '/addPhoneNumber/verifyOtp', (route) => false,
            arguments: phoneNumber);
      } else if (next is OtpStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
      } else if (next is OtpStateLoading) {
        FocusScope.of(context).unfocus();
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6: const TextStyle(
                color: Color(0xFFA1887F),
              ),
              bodyText2: const TextStyle(
                color: Color(0xFF9E9E9E),
              ))),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: MyIconButton(
              icon: Icons.arrow_back_ios_rounded,
              iconColor: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: Text(
            "Add Phone Number",
            style: GoogleFonts.prompt(
                textStyle: Theme.of(context).textTheme.headline6),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Text(
                    "Add your phone number for verification",
                    style: GoogleFonts.prompt(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      color: const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: LabeledTextField(
                        label: "Phone Number",
                        hintText: "0540000000",
                        controller: _controller,
                        validator: (value) =>
                            Validator.validatePhoneNumber(value!),
                        textInputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: ContinueButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(otpProvider.notifier)
                            .sendOtpCode(_controller.text.trim());
                      }
                    },
                  ),
                ),
              ],
            ),
            otpState is OtpStateLoading
                ? const OverlayLoadingScreen()
                : const SizedBox.shrink()
          ],
        )),
      ),
    );
  }
}
