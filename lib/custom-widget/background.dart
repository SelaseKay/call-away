import 'package:flutter/cupertino.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = const Color(0xFFCCB2A9);
    Rect backgroundRect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));

    Paint rightAnglePaint = Paint()..color = const Color(0xFFA1887F);
    Path rightAnglePath = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawRect(backgroundRect, backgroundPaint);
    canvas.drawPath(rightAnglePath, rightAnglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
