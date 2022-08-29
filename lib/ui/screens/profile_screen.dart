import 'package:call_away/provider/auth_provider.dart';
import 'package:call_away/services/auth_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/screens/change_password_screen.dart';
import 'package:call_away/ui/screens/my_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AuthenticationStateSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      } else if (next is AuthenticationStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorMessage,
            ),
          ),
        );
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
          primaryColor: const Color(0xFFA1887F),
          dividerTheme: const DividerThemeData(
            thickness: 1.5,
            color: Color(0xFFDDD3D0),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(
              left: 0.0,
              top: 4.0,
              bottom: 4.0,
              right: 0.0,
            ),
            side: const BorderSide(color: Color(0xFFEF5350)),
          )),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AppBarSection(
                          title: "Profile",
                          rPositionIcon: Icons.edit,
                          onRPositionIconPressed: () {
                            //On Right Position Icon Pressed
                          },
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: ListView(
                          children: [
                            const _ProfileHeader(),
                            const Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child: Divider()),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: _ProfileItem(
                                asset: "assets/images/mail.svg",
                                itemText: "judekwashie70@gmail.com",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
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
                              itemText: "My Reports",
                              isArrowVisible: true,
                              isClickable: true,
                              onPressed: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimatio) =>
                                        const MyReportsScreen(),
                                  )),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            _ProfileItem(
                              asset: "assets/images/change_password.svg",
                              itemText: "Change Password",
                              isArrowVisible: true,
                              isClickable: true,
                              onPressed: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimatio) =>
                                        const ChangePasswordScreen(),
                                  )),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: _LogoutButton(onPressed: () {
                                ref.read(authProvider.notifier).logoutUser();
                              }),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              authState is AuthenticationStateLoading
                  ? const LoadingScreen()
                  : const SizedBox.shrink()
            ],
          ),
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
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  splashFactory: NoSplash.splashFactory,
                ),
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
                        ? CircleAvatar(
                            backgroundColor:
                                const Color(0xFFE5A060).withOpacity(0.4),
                            foregroundColor: null,
                            radius: 16.0,
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xFFFFFFFF),
                              size: 16.0,
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              )
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: const Text(
          "Log Out",
          style: TextStyle(fontSize: 16.0, color: Color(0xFFEF5350)),
        ));
  }
}
