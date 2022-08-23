import 'package:call_away/ui/components/app_bar.dart';
import 'package:flutter/material.dart';

class MyCustomLayout extends StatelessWidget {
  const MyCustomLayout(
      {Key? key, required this.appBarTitle, required this.children, this.rPositionIcon})
      : super(key: key);

  final String appBarTitle;

  final List<Widget> children;

  final IconData? rPositionIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AppBarSection(
                title: appBarTitle,
                rPositionIcon: rPositionIcon,
              )),
          Expanded(
              child: ListView(
            children: children,
          ))
        ]),
      ),
    ));
  }
}
