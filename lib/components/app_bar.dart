import 'package:flutter/material.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection({Key? key, required this.title, this.isRightWidgetVisible = true}) : super(key: key);

  final String title;
  final bool isRightWidgetVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconButton(
          icon: Icons.arrow_back_ios_rounded,
          iconColor: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        Visibility(
          visible: isRightWidgetVisible,
          child: _IconButton(
            icon: Icons.edit,
            iconColor: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
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
