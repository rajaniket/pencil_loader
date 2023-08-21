import 'dart:math';

import 'package:flutter/material.dart';

class PencilBodyPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;

  PencilBodyPainter({
    this.startAngle = 0,
    this.sweepAngle = 4 * pi / 3,
    this.strokeWidth = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);
    Paint pencilBody1 = Paint()
      ..color = const Color(0xFFC4452D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    Paint pencilBody2 = Paint()
      ..color = const Color(0xFF141110)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    Paint pencilBody3 = Paint()
      ..color = const Color(0xFFC8634E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2 * strokeWidth),
      startAngle,
      sweepAngle,
      false,
      pencilBody1,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth),
      startAngle,
      sweepAngle,
      false,
      pencilBody2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      pencilBody3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
