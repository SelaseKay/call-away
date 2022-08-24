import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final VoidCallback? onPressed;

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 40.0,
      child: Material(
        color: const Color(0xFFEFEFEF),
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
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
