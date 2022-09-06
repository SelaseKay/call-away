import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.height = 40.0,
    this.width = 40.0,
    this.buttonColor = const Color(
      0xFFEFEFEF,
    ),
    this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback? onPressed;

  final Color iconColor;

  final Color buttonColor;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            height / 2,
          ),
        ),
        child: InkWell(
          focusColor: const Color(0xFFEFEFEF),
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          onTap: onPressed,
          child: Center(
              child: Icon(
            icon,
            color: iconColor,
          )),
        ),
      ),
    );
  }
}
