import 'package:call_away/ui/components/continue_button.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/screens/otp_verification-screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPhoneNumberScreen extends StatelessWidget {
  const AddPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "Add Phone Number",
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
                "Add your phone number for verification",
                style: GoogleFonts.prompt(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    color: const Color(0xFF9E9E9E)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: LabeledTextField(
                  label: "Phone Number",
                  hintText: "0541439384",
                  keyboardType: TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ContinueButton(onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      // transitionDuration:
                      //     const Duration(milliseconds: 550),
                      pageBuilder: (context, animation, secondaryAnimatio) =>
                          OtpVerificationScreen(),
                    ));
              }),
            ),
          ],
        )),
      ),
    );
  }
}
