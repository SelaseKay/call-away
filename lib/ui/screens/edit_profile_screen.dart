import 'package:call_away/provider/profile_update_state_provider.dart';
import 'package:call_away/services/profile_update_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/loading_screen.dart';
import 'package:call_away/ui/components/user_avatar.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends ConsumerWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    final profileUpdateState = ref.watch(profileUpdateStateProvider);

    ref.listen(profileUpdateStateProvider, (previous, next) {
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
        Navigator.pop(context);
      }
    });

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: const Color(0xFFA1887F),
        dividerTheme: const DividerThemeData(
          thickness: 1.0,
          color: Color(0xFFDDD3D0),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 0.0,
            top: 4.0,
            bottom: 4.0,
            right: 0.0,
          ),
          side: const BorderSide(
            color: Color(0xFFDA7B23),
          ),
        )),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xFFA1887F),
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
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
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
                        title: "Edit Profile",
                        action: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    24,
                                  ),
                                ),
                              ),
                              side: const BorderSide(
                                color: Color(0xFFDA7B23),
                                width: 1,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final username = _nameController.text.trim();
                                final email = _emailController.text.trim();
                                ref
                                    .read(profileUpdateStateProvider.notifier)
                                    .updateUserNameEmail(username, email);
                              }
                            },
                            child: Text(
                              "Save",
                              style: GoogleFonts.prompt(
                                textStyle: const TextStyle(
                                  color: Color(0xFFDA7B23),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32.0,
                              ),
                              child: UserAvatar(
                                onPressed: () => _showModalBottomSheet(context),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 16.0,
                            ),
                            LabeledTextField(
                              label: "Username",
                              controller: _nameController,
                              validator: (value) =>
                                  Validator.validateUsername(value!),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            LabeledTextField(
                              label: "Email",
                              validator: (value) =>
                                  Validator.validateEmail(value!),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            profileUpdateState is ProfileUpdateStateLoading
                ? const LoadingScreen()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class _MyModalBottomSheet extends StatelessWidget {
  const _MyModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
                onPressed: () {},
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
    return Column(
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
    );
  }
}
