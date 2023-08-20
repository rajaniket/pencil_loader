import 'dart:math';

import 'package:flutter/material.dart';

class PencilStrokePainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final double strokeWidth;

  PencilStrokePainter({this.startAngle = -2 * pi / 3, this.sweepAngle = 4 * pi / 3, this.strokeWidth = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);

    Paint pencilStrokePaint = Paint()
      ..color = const Color(0xFF6E6C6C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 2
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 6),
      startAngle,
      sweepAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilStrokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
