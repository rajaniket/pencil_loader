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
    // Calculate radius and center of the drawing area
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);

    // Define different paints for the three segments of the pencil body
    Paint pencilBodyPaint1 = Paint()
      ..color = const Color(0xFFC4452D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    Paint pencilBodyPaint2 = Paint()
      ..color = const Color(0xFF141110)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    Paint pencilBodyPaint3 = Paint()
      ..color = const Color(0xFFC8634E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw the first segment of the pencil body
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2 * strokeWidth),
      startAngle,
      sweepAngle,
      false,
      pencilBodyPaint1,
    );

    // Draw the second segment of the pencil body
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth),
      startAngle,
      sweepAngle,
      false,
      pencilBodyPaint2,
    );

    // Draw the third segment of the pencil body
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      pencilBodyPaint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when requested
  }
}
