import 'dart:math';

import 'package:flutter/material.dart';

class PencilEraserPainter extends CustomPainter {
  final double sweepAngle;

  PencilEraserPainter({this.sweepAngle = 4 * pi / 3});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);
    Paint eraserBody = Paint()
      ..color = const Color.fromARGB(255, 208, 44, 11).withOpacity(0.7)
      ..style = PaintingStyle.fill;
    Paint eraserBody1 = Paint()
      ..color = const Color.fromARGB(255, 208, 44, 11).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    Paint eraserBody2 = Paint()
      ..color = const Color.fromRGBO(242, 242, 241, 1)
      ..style = PaintingStyle.fill;
    Paint eraserBodyLines = Paint()
      ..color = const Color.fromARGB(255, 201, 197, 197)
      ..style = PaintingStyle.fill;
    Paint eraserBody3 = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    Paint eraserBody4 = Paint()
      ..color = Colors.grey.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    double eraserAngleOffset = sweepAngle + pi / 20;
    Offset eraserCenter = center.translate((radius - 12) * cos(eraserAngleOffset), (radius - 12) * sin(eraserAngleOffset));
    canvas.translate(eraserCenter.dx, eraserCenter.dy); // new origin
    canvas.rotate(sweepAngle);
    // drawing rect based on new origin
    canvas.drawRRect(RRect.fromRectXY(Rect.fromCenter(center: const Offset(1.5, 0), width: 36, height: 36), 7, 7), eraserBody);
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromCenter(center: const Offset(-12, 0), width: 8, height: 36),
            bottomLeft: const Radius.circular(7), topLeft: const Radius.circular(7)),
        eraserBody1);
    canvas.drawRect(Rect.fromCenter(center: const Offset(1.5, -6), width: 36, height: 24), eraserBody2);
    canvas.drawRect(Rect.fromCenter(center: const Offset(1.5, -10), width: 36, height: 2), eraserBodyLines);
    canvas.drawRect(Rect.fromCenter(center: const Offset(1.5, -2), width: 36, height: 2), eraserBodyLines);
    canvas.drawRect(Rect.fromCenter(center: const Offset(-13, -6), width: 8, height: 24), eraserBody3);
    canvas.drawRect(Rect.fromCenter(center: const Offset(-2, -6), width: 14, height: 24), eraserBody4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
