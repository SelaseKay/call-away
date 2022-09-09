import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_away/provider/user_profile_pic_state_provider.dart';
import 'package:call_away/services/profile_update_service.dart';
import 'package:call_away/services/user_pic_update_service.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    Key? key,
    required this.onPressed,
    this.profilePicUrl = "",
    this.placeholderImage,
  }) : super(key: key);

  final String profilePicUrl;

  final XFile? placeholderImage;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfilePicState = ref.watch(userProfilPicStateProvider);

    return profilePicUrl.isEmpty
        ? _NoProfileImage(
            onPressed: onPressed,
            userProfilePicState: userProfilePicState,
          )
        : _ProfileImage(
            onPressed: onPressed,
            userProfilePicState: userProfilePicState,
            placeholderImage: placeholderImage,
            profilePicUrl: profilePicUrl);
  }
}

class _NoProfileImage extends StatelessWidget {
  const _NoProfileImage({
    Key? key,
    required this.onPressed,
    required this.userProfilePicState,
  }) : super(key: key);

  final UserProfilePictureState userProfilePicState;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 108.0,
          width: 108.0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 108.0,
                width: 108.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      54.0,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: onPressed,
                  child: userProfilePicState is ProfileUpdateStateLoading
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.person,
                          size: 48.0,
                          color: Colors.white,
                        ),
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: MyIconButton(
                  icon: Icons.photo_camera,
                  iconColor: Colors.white,
                  buttonColor: const Color(0xFFE48938),
                  onPressed: onPressed,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(
      {Key? key,
      required this.onPressed,
      required this.userProfilePicState,
      this.placeholderImage,
      required this.profilePicUrl})
      : super(key: key);

  final VoidCallback onPressed;

  final UserProfilePictureState userProfilePicState;

  final XFile? placeholderImage;

  final String profilePicUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: onPressed,
              child: SizedBox(
                width: 108.0,
                height: 108.0,
                child: userProfilePicState is UserProfilePictureStateLoading
                    ? _ProfilePicturePlaceHolder(
                        placeholderImage: placeholderImage!,
                      )
                    : CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(54.0),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        imageUrl: profilePicUrl,
                        fit: BoxFit.fill,
                        placeholder: (context, url) {
                          return placeholderImage != null
                              ? _ProfilePicturePlaceHolder(
                                  placeholderImage: placeholderImage!,
                                )
                              : const SizedBox(
                                  height: 108,
                                  width: 108.0,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: MyIconButton(
                icon: Icons.photo_camera,
                iconColor: Colors.white,
                buttonColor: const Color(0xFFE48938),
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ],
    );
  }
}

//Loading profile image
class _ProfilePicturePlaceHolder extends StatelessWidget {
  const _ProfilePicturePlaceHolder({Key? key, required this.placeholderImage})
      : super(key: key);

  final XFile placeholderImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(54.0)),
            image: DecorationImage(
              image: FileImage(
                File(placeholderImage.path),
              ),
            ),
          ),
        ),
        const Positioned(
            top: 38.0, left: 38.0, child: CircularProgressIndicator()),
      ],
    );
  }
}
