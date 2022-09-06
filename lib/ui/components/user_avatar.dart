import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_away/ui/components/icon_button.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final String _url = "";

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _url.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 108.0,
                width: 108.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: onPressed,
                      child: Container(
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
                        child: const Icon(
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
                          imageUrl: _url,
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
