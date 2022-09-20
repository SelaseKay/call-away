import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoadingScreen extends StatelessWidget {
  const OverlayLoadingScreen({
    Key? key,
    this.loadingText = "",
  }) : super(key: key);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: const Color(0xFFDA7B23),
              size: 32.0,
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            loadingText,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
