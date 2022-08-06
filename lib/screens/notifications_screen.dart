import 'package:call_away/components/app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:  Theme.of(context).copyWith(
          primaryColor: const Color(0xFFA1887F),
          textTheme: const TextTheme(
              headline6: TextStyle(color: Color(0xFFA1887F)),
              subtitle1: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF252525),
              ),
              subtitle2: TextStyle(color: Color(0xFF999999)),
              bodyText1: TextStyle(color: Color(0xFFD9D9D9)))
          ),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: const [
            Padding(
              padding:EdgeInsets.only(top: 8.0),
              child: AppBarSection(
                title: "Notifications",
                isRightWidgetVisible: false,
              ),
            )
          ]),
        )),
      ),
    );
  }
}
