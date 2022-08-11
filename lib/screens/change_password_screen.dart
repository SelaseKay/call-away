import 'package:call_away/components/custom_layout.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child:
            const MyCustomLayout(appBarTitle: "Change Password", children: []));
  }
}
