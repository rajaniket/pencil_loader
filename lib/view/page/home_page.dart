import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pencil_loader/view/painter/pencil_body_painter.dart';
import 'package:pencil_loader/view/painter/pencil_eraser_painter.dart';
import 'package:pencil_loader/view/painter/pencil_point_painter.dart';

import '../painter/pencil_stroke_painter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _roationController;
  late Animation<double> _rotationAnimationFirst;
  late Animation<double> _rotationAnimationSecond;
  late Animation<double> _strokeAnimationFirst;
  late Animation<double> _strokeAnimationSecond;
  late Animation<double> _pencilSizeAnimationSweepAngleFirst;
  late Animation<double> _pencilSizeAnimationSweepAngleSecond;
  late Animation<double> _skewAnimation;
  double strokeWidth = 15;
  Duration duration = const Duration(seconds: 10);
  double startAngle = (-2 * pi / 3) + pi / 10; //

  @override
  void initState() {
    super.initState();

    _roationController = AnimationController(vsync: this, duration: duration)..repeat();
    _strokeAnimationFirst = Tween<double>(begin: -2 * pi / 3, end: 2 * pi / 3).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0, 0.5),
    ));
    _strokeAnimationSecond = Tween<double>(begin: -2 * pi / 3, end: 2 * pi / 3).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0.5, 0.75),
    ));
    _rotationAnimationFirst = Tween<double>(begin: 0, end: 4 * pi / 3).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0, 0.5),
      ),
    );
    _rotationAnimationSecond = Tween<double>(begin: 4 * pi / 3, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0.5, 1),
      ),
    );
    _skewAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0.42, 0.75),
      ),
    );
    _pencilSizeAnimationSweepAngleFirst = Tween<double>(begin: pi / 6, end: (2 * pi / 3) + pi / 10).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0, 0.5),
    ));
    _pencilSizeAnimationSweepAngleSecond = Tween<double>(begin: (2 * pi / 3) + pi / 10, end: pi / 6).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0.5, 1),
    ));
  }

  @override
  void dispose() {
    _roationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD0DCF9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 250,
                width: 250,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedBuilder(
                        animation: _roationController,
                        builder: (context, _) {
                          // print("--- ${5 * _roationController.value}");
                          return CustomPaint(
                            painter: PencilStrokePainter(
                              strokeWidth: strokeWidth,
                              startAngle: _strokeAnimationSecond.value,
                              sweepAngle: _strokeAnimationFirst.value -
                                  _strokeAnimationSecond.value, // subtracting with _strokeAnimationEnd.value to make it still or balanced
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: _roationController,
                        builder: (context, _) {
                          return Transform.rotate(
                            angle: _roationController.value < 0.5 ? _rotationAnimationFirst.value : _rotationAnimationSecond.value,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CustomPaint(
                                    painter: PencilBodyPainter(
                                  strokeWidth: strokeWidth,
                                  startAngle: (-2 * pi / 3) + pi / 10,
                                  sweepAngle: _roationController.value < 0.5
                                      ? _pencilSizeAnimationSweepAngleFirst.value
                                      : _pencilSizeAnimationSweepAngleSecond.value,
                                )),
                                CustomPaint(
                                  painter: PencilEraserPainter(
                                    strokeWidth: strokeWidth,
                                    sweepAngle: (-2 * pi / 3) +
                                        pi / 10 +
                                        (_roationController.value < 0.5
                                            ? _pencilSizeAnimationSweepAngleFirst.value
                                            : _pencilSizeAnimationSweepAngleSecond.value),
                                    skewAngle: 0.15 * sin(2 * duration.inSeconds * _skewAnimation.value),
                                  ),
                                ),
                                CustomPaint(
                                  painter: PencilPointPainter(
                                    strokeWidth: strokeWidth,
                                    startAngle: -2 * pi / 3 + pi / 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
