import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pencil_loader/view/painter/pencil_body_painter.dart';
import 'package:pencil_loader/view/painter/pencil_eraser_painter.dart';
import 'package:pencil_loader/view/painter/pencil_point_painter.dart';

import '../painter/pencil_stroke_painter.dart';

class PencilLoader extends StatefulWidget {
  const PencilLoader({super.key, required this.duration});
  final int duration;

  @override
  State<PencilLoader> createState() => _PencilLoaderState();
}

class _PencilLoaderState extends State<PencilLoader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimationFirst;
  late Animation<double> _rotationAnimationSecond;
  late Animation<double> _strokeAnimationFirst;
  late Animation<double> _strokeAnimationSecond;
  late Animation<double> _pencilSizeAnimationSweepAngleFirst;
  late Animation<double> _pencilSizeAnimationSweepAngleSecond;
  late Animation<double> _skewAnimation;
  double strokeWidth = 15;
  double startAngle = (-2 * pi / 3) + pi / 10; // pi/10 is offset due to pencil nib

  @override
  void initState() {
    super.initState();
    initializeAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PencilLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _animationController.duration = Duration(seconds: widget.duration); // Update animation duration if widget's duration changes
      _animationController.repeat(); // Restart animation with new duration
    }
  }

  initializeAnimation() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: widget.duration))..repeat();
    _strokeAnimationFirst = Tween<double>(begin: -2 * pi / 3, end: 2 * pi / 3).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.5),
    ));
    _strokeAnimationSecond = Tween<double>(begin: -2 * pi / 3, end: 2 * pi / 3).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.75),
    ));
    _rotationAnimationFirst = Tween<double>(begin: 0, end: 4 * pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5),
      ),
    );
    _rotationAnimationSecond = Tween<double>(begin: 4 * pi / 3, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1),
      ),
    );
    _skewAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.42, 0.75),
      ),
    );
    _pencilSizeAnimationSweepAngleFirst = Tween<double>(begin: pi / 6, end: (2 * pi / 3) + pi / 10).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.5),
    ));
    _pencilSizeAnimationSweepAngleSecond = Tween<double>(begin: (2 * pi / 3) + pi / 10, end: pi / 6).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Animated pencil stroke animation
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return CustomPaint(
                painter: PencilStrokePainter(
                  strokeWidth: strokeWidth,
                  startAngle: _strokeAnimationSecond.value,
                  sweepAngle: _strokeAnimationFirst.value -
                      _strokeAnimationSecond.value, // subtracting with _strokeAnimationEnd.value to make it still or balanced
                ),
              );
            }),

        // Animated pencil body and eraser animations
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Transform.rotate(
                angle: _animationController.value < 0.5 ? _rotationAnimationFirst.value : _rotationAnimationSecond.value,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Pencil body animation
                    CustomPaint(
                        painter: PencilBodyPainter(
                      strokeWidth: strokeWidth,
                      startAngle: startAngle,
                      sweepAngle:
                          _animationController.value < 0.5 ? _pencilSizeAnimationSweepAngleFirst.value : _pencilSizeAnimationSweepAngleSecond.value,
                    )),

                    // Pencil eraser animation
                    CustomPaint(
                      painter: PencilEraserPainter(
                        strokeWidth: strokeWidth,
                        sweepAngle: startAngle +
                            (_animationController.value < 0.5
                                ? _pencilSizeAnimationSweepAngleFirst.value
                                : _pencilSizeAnimationSweepAngleSecond.value),
                        skewAngle: 0.18 * sin(7 * _skewAnimation.value),
                      ),
                    ),

                    // Pencil nib animation
                    CustomPaint(
                      painter: PencilPointPainter(
                        strokeWidth: strokeWidth,
                        startAngle: startAngle,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
