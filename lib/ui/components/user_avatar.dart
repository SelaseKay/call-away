import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_away/provider/profile_update_state_provider.dart';
import 'package:call_away/services/profile_update_service.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    Key? key,
    required this.onPressed,
    this.profilePicUrl = "",
  }) : super(key: key);

  final String profilePicUrl;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileUpdateState = ref.watch(profileUpdateStateProvider);

    print("profilePicUrl: $profilePicUrl");
    return profilePicUrl.isEmpty
        ? Column(
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
                        child: profileUpdateState is ProfileUpdateStateLoading
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
          )
        : Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                    onTap: onPressed,
                    child: SizedBox(
                      width: 108.0,
                      height: 108.0,
                      child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          // width: 108.0,
                          // height: 108.0,
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
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
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
    // : Stack(
    //     clipBehavior: Clip.none,
    //     children: [
    //       InkWell(
    //         onTap: onPressed,
    //         child: SizedBox(
    //           height: 108.0,
    //           width: 108.0,
    //           child: ClipRRect(
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(
    //                 54.0,
    //               ),
    //             ),
    //             child: CachedNetworkImage(
    //               imageUrl: _url,
    //               progressIndicatorBuilder:
    //                   (context, url, downloadProgress) =>
    //                       CircularProgressIndicator(
    //                 value: downloadProgress.progress,
    //               ),
    //               errorWidget: (context, url, error) =>
    //                   const Icon(Icons.error),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: 108.0,
    //         child: MyIconButton(
    //           icon: Icons.photo_camera,
    //           iconColor: Colors.white,
    //           buttonColor: const Color(0xFFE48938),
    //           onPressed: onPressed,
    //         ),
    //       )
    //     ],
    //   );
  }
}
