import 'dart:math';

import 'package:flutter/material.dart';

class PencilEraserPainter extends CustomPainter {
  final double sweepAngle;
  final double skewAngle;
  final double strokeWidth;

  PencilEraserPainter({
    this.sweepAngle = 4 * pi / 3,
    this.skewAngle = 0,
    this.strokeWidth = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);
    final double eraserHeight = 6 * strokeWidth;
    final double eraserWidth = 3 * strokeWidth;
    final double eraserHolderHeight = 0.7 * eraserHeight;

    Paint eraserBody = Paint()
      ..color = const Color(0xFF2EA9F1)
      ..style = PaintingStyle.fill;
    Paint eraserBody1 = Paint()
      ..color = const Color.fromARGB(255, 69, 143, 186)
      ..style = PaintingStyle.fill;
    Paint eraserBody2 = Paint()
      ..color = const Color.fromRGBO(242, 242, 241, 1)
      ..style = PaintingStyle.fill;
    Paint eraserBodyLines = Paint()
      ..color = const Color.fromARGB(255, 201, 197, 197)
      ..style = PaintingStyle.fill;
    Paint eraserBody3 = Paint()
      ..color = Colors.grey.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    Paint eraserBody4 = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    Offset eraserCenter = center.translate((radius - strokeWidth) * cos(sweepAngle), (radius - strokeWidth) * sin(sweepAngle));
    canvas.translate(eraserCenter.dx, eraserCenter.dy); // new origin
    canvas.rotate(sweepAngle);
    canvas.transform(Matrix4.skewX(skewAngle).storage); //-pi / 8
    // making a rectangle covering the whole eraser then clipping it from eraser's center to removing extra part, this has also been done to keep the base of rubber fixed as center portion remain static if skewAngle change.
    canvas.clipRect(Rect.fromLTWH(-eraserWidth, 0, eraserHeight * 2, eraserHeight)); // clipping the rubber from center,
    canvas.drawRRect(RRect.fromRectXY(Rect.fromCenter(center: const Offset(0, 0), width: eraserWidth, height: eraserHeight), 7, 7), eraserBody);
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromCenter(center: Offset(-strokeWidth, 0), width: 0.8 * strokeWidth, height: eraserHeight),
            bottomLeft: const Radius.circular(7), topLeft: const Radius.circular(7)),
        eraserBody1);

    canvas.drawRect(Rect.fromCenter(center: const Offset(0, 0), width: eraserWidth, height: eraserHolderHeight), eraserBody2);
    canvas.drawRect(Rect.fromCenter(center: Offset(0, eraserHolderHeight / 3), width: eraserWidth, height: 2), eraserBodyLines);
    canvas.drawRect(Rect.fromCenter(center: Offset(0, eraserHolderHeight / 6), width: eraserWidth, height: 2), eraserBodyLines);
    canvas.drawRect(Rect.fromCenter(center: Offset(-strokeWidth, 0), width: 0.9 * strokeWidth, height: eraserHolderHeight), eraserBody3);
    canvas.drawRect(Rect.fromCenter(center: const Offset(0, 0), width: strokeWidth, height: eraserHolderHeight), eraserBody4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
