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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _roationController;
  late Animation<double> _rotationAnimationFirst;
  late Animation<double> _rotationAnimationSecond;
//  late AnimationController _strokeController;
  late Animation<double> _strokeAnimationFirst;
  late Animation<double> _strokeAnimationSecond;
  late AnimationController _pencilSizeController;
  late Animation<double> _pencilSizeAnimationFirst;
  late Animation<double> _pencilSizeAnimationSecond;
  late Animation<double> _skewAnimation;
  double strokeWidth = 15;

  // double strokeStartAngle = -pi / 2;
  // double strokeEndAngle = 4 * pi / 3;
  bool isFirstRotation = false;
  @override
  void initState() {
    super.initState();

    _roationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..addListener(() {
        if (_roationController.value < 0.5) {
          isFirstRotation = true;
        } else {
          isFirstRotation = false;
        }
      })
      ..repeat();
    _skewAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0, 1),
      ),
    );

    _rotationAnimationFirst = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0, 0.5),
      ),
    );
    _rotationAnimationSecond = Tween<double>(begin: pi, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _roationController,
        curve: const Interval(0.5, 1),
      ),
    );
    // _strokeController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..repeat();
    _strokeAnimationFirst = Tween<double>(begin: -pi / 2, end: pi / 2).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0, 0.5),
    ));
    _strokeAnimationSecond = Tween<double>(begin: -pi / 2, end: pi / 2).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0.5, 0.75),
    ));

    _pencilSizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _pencilSizeAnimationFirst = Tween<double>(begin: 1 * pi / 6, end: 2 * pi / 3).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0, 0.5),
    ));
    _pencilSizeAnimationSecond = Tween<double>(begin: 2 * pi / 3, end: 1 * pi / 6).animate(CurvedAnimation(
      parent: _roationController,
      curve: const Interval(0.5, 1),
    ));
  }

  @override
  void dispose() {
    _roationController.dispose();
    // _strokeController.dispose();
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
                            angle: 0, //isFirstRotation ? _rotationAnimationFirst.value : _rotationAnimationSecond.value,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CustomPaint(
                                  painter: PencilBodyPainter(
                                    strokeWidth: strokeWidth,
                                    startAngle: -pi / 2,
                                    sweepAngle: (isFirstRotation ? _pencilSizeAnimationFirst.value : _pencilSizeAnimationSecond.value),
                                  ),
                                ),
                                CustomPaint(
                                  painter: PencilEraserPainter(
                                    strokeWidth: strokeWidth,
                                    sweepAngle: -pi / 2 + (isFirstRotation ? _pencilSizeAnimationFirst.value : _pencilSizeAnimationSecond.value),
                                    skewAngle: 0.15 * sin(3 * _skewAnimation.value),
                                  ),
                                ),
                                CustomPaint(
                                  painter: PencilPointPainter(
                                    strokeWidth: strokeWidth,
                                    startAngle: -pi / 2,
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
