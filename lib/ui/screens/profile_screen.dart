import 'package:call_away/provider/auth_provider.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/provider/current_user_provider.dart';
import 'package:call_away/provider/user_profile_pic_state_provider.dart';
import 'package:call_away/services/auth_service.dart';
import 'package:call_away/services/profile_update_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/user_avatar.dart';
import 'package:call_away/ui/screens/change_password_screen.dart';
import 'package:call_away/ui/screens/edit_profile_screen.dart';
import 'package:call_away/ui/screens/my_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() async {
    await ref.read(authProvider.notifier).getCurrentUserModel();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    final userProfilePicState = ref.watch(userProfilPicStateProvider);

    final currentUser = ref.watch(currentUserProvider);


    print("Authentication state: $authState");

    ref.listen(authProvider, (previous, next) {
      if (next is AuthenticationStateSuccess) {
        if (next.user == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
        }
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
          side: const BorderSide(
            color: Color(0xFFEF5350),
          ),
        )),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xFFA1887F),
          ),
          subtitle1: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF252525),
          ),
          subtitle2: TextStyle(
            color: Color(0xFF999999),
          ),
          bodyText1: TextStyle(
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              authState is AuthenticationStateLoading
                  ? const LoadingScreen()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: AppBarSection(
                                title: "Profile",
                                action: MyIconButton(
                                  icon: Icons.edit,
                                  iconColor: const Color(0xFFA1887F),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimatio) =>
                                            EditProfileScreen(
                                          curentUser: authState
                                                  is AuthenticationStateSuccess
                                              ? authState.user
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 40.0,
                              ),
                              child: ListView(
                                children: [
                                  _ProfileHeader(
                                    userName:
                                        authState is AuthenticationStateSuccess
                                            ? authState.user!.username
                                            : "",
                                    url: authState is AuthenticationStateSuccess
                                        ? authState.user!.profilePicUrl
                                        : "",
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 40.0,
                                    ),
                                    child: Divider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 24.0,
                                    ),
                                    child: _ProfileItem(
                                      asset: "assets/images/mail.svg",
                                      itemText: authState
                                              is AuthenticationStateSuccess
                                          ? authState.user!.email
                                          : "",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  _ProfileItem(
                                    asset: "assets/images/phone.svg",
                                    itemText:
                                        authState is AuthenticationStateSuccess
                                            ? authState.user!.phone
                                            : "",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                                                secondaryAnimation) =>
                                            const ChangePasswordScreen(),
                                      ),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                    ),
                                    child: _LogoutButton(onPressed: () {
                                      ref
                                          .read(authProvider.notifier)
                                          .logoutUser();
                                    }),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  const _ProfileHeader(
      {Key? key, this.userName = "Kwashie Jude", required this.url})
      : super(key: key);

  final String userName;

  final String url;

  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            8.0,
          ),
          topRight: Radius.circular(
            8.0,
          ),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return const _MyModalBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userProfilPicStateProvider, (previous, next) {
      if (next is ProfileUpdateStateLoading) {
        FocusScope.of(context).unfocus();
      } else if (next is ProfileUpdateStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
          ),
        );
      } else if (next is ProfileUpdateStateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage),
          ),
        );
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            UserAvatar(
                profilePicUrl: url,
                onPressed: () {
                  _showModalBottomSheet(context);
                }),
          ],
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

class _MyModalBottomSheet extends ConsumerWidget {
  const _MyModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<XFile?>(cameraImageProvider, (previous, next) {
      if (next != null) {
        Navigator.pop(context);
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Photo",
            style: TextStyle(
              color: const Color(0xFF000000).withOpacity(0.75),
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              _ModalBottomSheetItem(
                text: "Camera",
                onPressed: () async {
                  final profileImage = await ref
                      .read(cameraImageProvider.notifier)
                      .getImageFromCamera();
                  await ref
                      .read(userProfilPicStateProvider.notifier)
                      .updateProfilePic(profileImage);
                },
                child: const MyIconButton(
                  icon: Icons.photo_camera,
                  iconColor: Color(0xFFE48938),
                  buttonColor: Color(0xFFD3D3D3),
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              const SizedBox(
                width: 32.0,
              ),
              _ModalBottomSheetItem(
                text: "Gallery",
                onPressed: () async {
                  print("gallery item clicked");
                  final profileImage = await ref
                      .read(cameraImageProvider.notifier)
                      .getImageFromGallery();
                  await ref
                      .read(userProfilPicStateProvider.notifier)
                      .updateProfilePic(profileImage);
                },
                child: const MyIconButton(
                  icon: Icons.image,
                  iconColor: Color(0xFFE48938),
                  buttonColor: Color(0xFFD3D3D3),
                  height: 40.0,
                  width: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModalBottomSheetItem extends StatelessWidget {
  const _ModalBottomSheetItem({
    Key? key,
    required this.child,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          child,
          const SizedBox(
            height: 4.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF111111).withOpacity(0.50),
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
