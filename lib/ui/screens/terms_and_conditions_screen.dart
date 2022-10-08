import 'package:call_away/constants.dart';
import 'package:call_away/provider/otp_provider.dart';
import 'package:call_away/services/otp_service.dart';
import 'package:call_away/ui/components/continue_button.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/overlay_loading_screen.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              headline6: const TextStyle(
                color: Color(0xFFA1887F),
              ),
              bodyText2: const TextStyle(
                color: Color(0xFF9E9E9E),
              ),
            ),
      ),
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
            "Terms And Conditions",
            style: GoogleFonts.prompt(
                textStyle: Theme.of(context).textTheme.headline6),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(termsAndConditionsText, style: GoogleFonts.prompt(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF3C3C3C)
                    )
                  ),)
                ],
              ),
            )
            ),
      ),
    );
  }
}
