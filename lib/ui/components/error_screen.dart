import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "An error occured!!",
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF525252),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
