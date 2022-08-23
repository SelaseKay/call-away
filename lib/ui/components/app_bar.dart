import 'package:call_away/ui/components/icon_button.dart';
import 'package:flutter/material.dart';

class AppBarSection extends StatelessWidget {
  const AppBarSection(
      {Key? key,
      required this.title,
      this.onRPositionIconPressed,
      this.isRightWidgetVisible = true,
      this.rPositionIcon})
      : super(key: key);

  final String title;
  final bool isRightWidgetVisible;

  final IconData? rPositionIcon;

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
          rPositionIcon == null
              ? const SizedBox(
                  height: 40.0,
                  width: 40.0,
                )
              : MyIconButton(
                  icon: rPositionIcon!,
                  iconColor: Theme.of(context).primaryColor, onPressed: onRPositionIconPressed,)
        ],
      ),
    );
  }
}

// class _IconButton extends StatelessWidget {
//   const _IconButton({
//     Key? key,
//     required this.icon,
//     required this.iconColor,
//     this.onPressed,
//   }) : super(key: key);
//   final IconData icon;
//   final VoidCallback? onPressed;

//   final Color iconColor;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40.0,
//       width: 40.0,
//       child: Material(
//         color: const Color(0xFFEFEFEF),
//         borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//         child: InkWell(
//           borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//           onTap: onPressed,
//           child: Center(
//               child: Icon(
//             icon,
//             color: iconColor,
//           )),
//         ),
//       ),
//     );
//   }
// }
