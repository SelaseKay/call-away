import 'package:flutter/material.dart';

class OverlayLoadingScreen extends StatelessWidget {
  const OverlayLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
