import 'package:call_away/model/user.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/provider/profile_update_state_provider.dart';
import 'package:call_away/services/profile_update_service.dart';
import 'package:call_away/ui/components/app_bar.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:call_away/ui/components/labeled_textfield.dart';
import 'package:call_away/ui/components/overlay_loading_screen.dart';
import 'package:call_away/utils/user_input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key, this.curentUser}) : super(key: key);

  final UserModel? curentUser;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: widget.curentUser!.username);
    _emailController = TextEditingController(text: widget.curentUser!.email);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final username = _nameController.text.trim();
                              final email = _emailController.text.trim();

                              await ref
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
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
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
                ? const OverlayLoadingScreen()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
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
                  await ref
                      .read(cameraImageProvider.notifier)
                      .getImageFromCamera();
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
                  await ref
                      .read(cameraImageProvider.notifier)
                      .getImageFromGallery();
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
