import 'package:call_away/provider/otp_provider.dart';
import 'package:call_away/services/otp_service.dart';
import 'package:call_away/ui/components/continue_button.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends ConsumerWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpProvider);

    ref.listen(otpProvider, (previous, next) {
      if (next is OtpStateSuccess) {
        Navigator.pushNamed(context, 'home');
      } else if (next is OtpStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage)));
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6: const TextStyle(
                color: Color(0xFFA1887F),
              ),
              bodyText2: const TextStyle(color: Color(0xFF9E9E9E)))),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: MyIconButton(
              icon: Icons.arrow_back_ios_rounded,
              iconColor: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: Text(
            "Verfication",
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    "We sent you a code to verify your phone number.",
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        color: const Color(0xFF9E9E9E)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Form(
                        onChanged: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _OtpTextField(
                              controller: _controller1,
                              autoFocus: true,
                            ),
                            _OtpTextField(controller: _controller2),
                            _OtpTextField(controller: _controller3),
                            _OtpTextField(controller: _controller4),
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ContinueButton(onPressed: () async {
                    var otpCode = _controller1.text +
                        _controller2.text +
                        _controller3.text +
                        _controller4.text;
                    print("otp code is: $otpCode");
                    if (otpCode.length != 4) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Entered code is incomplete")));
                    } else {
                      await ref
                          .read(otpProvider.notifier)
                          .verifiyUserOtp(otpCode);
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CustomTextSpan(
                      onTapText: () {},
                      clickableText: "\nResend",
                      unclickableText: "I didn't receive a code."),
                )
              ],
            ),
            otpState is OtpStateLoading ? const LoadingScreen() : const SizedBox.shrink()
          ],
        )),
      ),
    );
  }
}

class _OtpTextField extends ConsumerWidget {
  const _OtpTextField(
      {Key? key, required this.controller, this.autoFocus = false})
      : super(key: key);

  final TextEditingController controller;
  final bool autoFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 64.0,
      width: 56.0,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        controller: controller,
        autofocus: autoFocus,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
