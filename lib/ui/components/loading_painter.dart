import 'package:flutter/material.dart';

class LoadingPainter extends CustomPainter {
  const LoadingPainter({required this.top});

  final double top;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final rect =
        Rect.fromPoints( Offset(0, top), Offset(size.width / 8.0, size.height / 8.0));
    final rrect = RRect.fromRectXY(rect, 16.0, 16.0);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
