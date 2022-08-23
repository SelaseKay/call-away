import 'package:call_away/provider/otp_code_provider.dart';
import 'package:call_away/ui/components/continue_button.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends ConsumerWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var otpCode = ref.watch(otpCodeProvider);

    ref.listen(otpCodeProvider, ((previous, next) {
      print("Otp code is: $next");
    }));

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
            child: ListView(
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
            const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: _OtpCodeTextFields(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child:
                  ContinueButton(onPressed: otpCode.length == 4 ? () {} : null),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CustomTextSpan(
                  onTapText: () {},
                  clickableText: "\nResend",
                  unclickableText: "I didn't receive a code."),
            )
          ],
        )),
      ),
    );
  }
}

class _OtpCodeTextFields extends ConsumerWidget {
  const _OtpCodeTextFields({Key? key}) : super(key: key);

  void updateOtpCode(
      BuildContext context, String currentOtpCode, WidgetRef ref) {
    if (currentOtpCode.length == 1) {
      ref.read(otpCodeProvider.notifier).state =
          ref.read(otpCodeProvider.notifier).state + currentOtpCode;
      FocusScope.of(context).nextFocus();
    } else if (currentOtpCode.length != 1 &&
        ref.read(otpCodeProvider.notifier).state.isNotEmpty) {
      var otpCode = ref.read(otpCodeProvider.notifier).state;
      ref.read(otpCodeProvider.notifier).state =
          otpCode.substring(0, otpCode.length - 2);
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 64.0,
          width: 56.0,
          child: TextFormField(
            onSaved: (pin1) {},
            onChanged: (value) => updateOtpCode(context, value, ref),
            decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                    ),
                 
                  ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 64.0,
          width: 56.0,
          child: TextFormField(
            onChanged: (value) => updateOtpCode(context, value, ref),
            decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                    ),
                 
                  ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 64.0,
          width: 56.0,
          child: TextFormField(
            onChanged: (value) => updateOtpCode(context, value, ref),
            decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                    ),
                 
                  ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        SizedBox(
          height: 64.0,
          width: 56.0,
          child: TextFormField(
            onChanged: (value) => updateOtpCode(context, value, ref),
            decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                    ),
                 
                  ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
      ],
    ));
  }
}
