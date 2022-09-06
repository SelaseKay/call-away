import 'package:call_away/ui/components/icon_button.dart';
import 'package:flutter/material.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection(
      {Key? key, required this.title, this.onRPositionIconPressed, this.action})
      : super(key: key);

  final String title;

  final Widget? action;

  final VoidCallback? onRPositionIconPressed;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: const Color(0xFFA1887F),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            icon: Icons.arrow_back_ios_rounded,
            iconColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          action == null
              ? const SizedBox(
                  height: 40.0,
                  width: 40.0,
                )
              : action!
        ],
      ),
    );
  }
}
