import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_away/provider/camera_image_provider.dart';
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
    final image = ref.watch(cameraImageProvider);

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
                      decoration: BoxDecoration(
                        color: const Color(0xFF777777),
                        image: image != null
                            ? DecorationImage(
                              fit: BoxFit.cover,
                                image: FileImage(
                                  File(image.path),
                                ),
                              )
                            : null,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            54.0,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: onPressed,
                        child: image ==null ? const Icon(
                          Icons.person,
                          size: 48.0,
                          color: Colors.white,
                        ) : const SizedBox.shrink(),
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
              SizedBox(
                height: 108.0,
                width: 108.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: onPressed,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            54.0,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: profilePicUrl,
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
