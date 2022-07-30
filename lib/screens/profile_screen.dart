import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFA1887F),
          dividerTheme: const DividerThemeData(
            thickness: 1.5,
            color: Color(0xFFDDD3D0),
          ),
          textTheme: const TextTheme(
              headline6: TextStyle(color: Color(0xFFA1887F)),
              subtitle1: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF252525),
              ),
              subtitle2: TextStyle(color: Color(0xFF999999)),
              bodyText1: TextStyle(color: Color(0xFFD9D9D9)))),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 8.0), child: _AppBarSection()),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ListView(
                  children: [
                    const _ProfileHeader(),
                    const Padding(
                        padding: EdgeInsets.only(top: 40.0), child: Divider()),
                    _ProfileItem(
                      asset: "assets/images/mail.svg",
                      itemText: "judekwashie70@gmail.com",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _ProfileItem(
                      asset: "assets/images/phone.svg",
                      itemText: "+233 54 143 9384",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _ProfileItem(
                      asset: "assets/images/report_history.svg",
                      itemText: "Report History",
                      isArrowVisible: true,
                      isClickable: true,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const _ProfileItem(
                      asset: "assets/images/log_out.svg",
                      itemText: "Log out",
                      isClickable: true,
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xFFEF5350)),
                    ),
                  ],
                ),
              ))
            ],
          ),
        )),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconButton(
          icon: Icons.arrow_back_ios_rounded,
          iconColor: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
        Text(
          "Profile",
          style: Theme.of(context).textTheme.headline6,
        ),
        _IconButton(
          icon: Icons.edit,
          iconColor: Theme.of(context).primaryColor,
          onPressed: () {},
        )
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton(
      {Key? key,
      required this.icon,
      required this.iconColor,
      this.onPressed,
      this.height = 40.0,
      this.width = 40.0})
      : super(key: key);
  final IconData icon;
  final VoidCallback? onPressed;

  final double height;
  final double width;

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({Key? key, this.userName = "Kwashie Jude"})
      : super(key: key);

  final String _url = "";
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _url.isEmpty
            ? const CircleAvatar(
                radius: 44.0,
                backgroundColor: Color(0xFFDBDBDB),
              )
            : CircleAvatar(
                radius: 44.0,
                backgroundImage: NetworkImage(_url),
              ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          userName,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem(
      {Key? key,
      this.asset = "assets/images/log_out.svg",
      this.isClickable = false,
      this.itemText = "Log out",
      this.onPressed,
      this.isArrowVisible = false,
      required this.style})
      : super(key: key);

  final String asset;
  final String itemText;

  final TextStyle? style;

  final bool isClickable;
  final bool isArrowVisible;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !isClickable
        ? Row(
            children: [
              SvgPicture.asset(asset),
              const SizedBox(
                width: 24.0,
              ),
              Text(
                itemText,
                style: style,
              )
            ],
          )
        : TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
          onPressed: onPressed,
          child: Row(
            children: [
              SvgPicture.asset(asset),
              const SizedBox(
                width: 24.0,
              ),
              Expanded(
                child: Text(
                  itemText,
                  style: style,
                ),
              ),
              isArrowVisible
                  ? const _IconButton(
                      icon: Icons.arrow_forward_ios_rounded,
                      iconColor: Color(0xFF757575),
                      height: 32.0,
                      width: 32.0,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }
}
