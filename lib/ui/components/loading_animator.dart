import 'package:call_away/ui/components/loading_painter.dart';
import 'package:flutter/material.dart';

class LoadingAnimator extends StatefulWidget {
  const LoadingAnimator({Key? key})
      : super(key: key);


  @override
  State<LoadingAnimator> createState() => _LoadingAnimatorState();
}

class _LoadingAnimatorState extends State<LoadingAnimator>
    with TickerProviderStateMixin {
  late Animation<double> top;

  late Animation<Offset> bottom;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    Tween<double> topOffsetTween = Tween(begin: 60.0, end: -40.0);

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    top = topOffsetTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.0,
        width: 80.0,
        child: CustomPaint(
          painter: LoadingPainter(top: top.value),
        ));
  }
}
