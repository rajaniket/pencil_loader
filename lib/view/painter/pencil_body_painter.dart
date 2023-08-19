import 'dart:math';

import 'package:flutter/material.dart';

class PencilBodyPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;

  PencilBodyPainter({this.startAngle = 0, this.sweepAngle = 4 * pi / 3});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);
    Paint pencilBody1 = Paint()
      ..color = const Color(0xFF0C4CEF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    Paint pencilBody2 = Paint()
      ..color = const Color(0xFF0C4CEF).withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    Paint pencilBody3 = Paint()
      ..color = const Color(0xFF0C4CEF).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 24),
      startAngle, // -120 degree
      sweepAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody1,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 12),
      startAngle, // -120 degree
      sweepAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, // -120 degree
      sweepAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
