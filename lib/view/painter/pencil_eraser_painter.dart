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

    Paint eraserBodyPaint = Paint()
      ..color = const Color(0xFF7B84FC)
      ..style = PaintingStyle.fill;
    Paint eraserBodyShadowPaint = Paint()
      ..color = const Color(0xFF636CEE)
      ..style = PaintingStyle.fill;
    Paint eraserHolderPaint = Paint()
      ..color = const Color(0xFFF2F2F1)
      ..style = PaintingStyle.fill;
    Paint eraserHolderLinePaint = Paint()
      ..color = const Color(0xFFC9C5C5)
      ..style = PaintingStyle.fill;
    Paint eraserHolderCoverPaint1 = Paint()
      ..color = Colors.grey.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    Paint eraserHolderCoverPaint2 = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // Calculate the center of the eraser
    Offset eraserCenter = center.translate((radius - strokeWidth) * cos(sweepAngle), (radius - strokeWidth) * sin(sweepAngle));

    // Shift the origin of the canvas to the eraser center
    canvas.translate(eraserCenter.dx, eraserCenter.dy); // new origin

    // Rotate the canvas as per the sweepAngle
    canvas.rotate(sweepAngle);

    // skewing the visible portion of the eraser
    canvas.transform(Matrix4.skewX(skewAngle).storage);

    // Create a rectangle covering the entire eraser, and then apply clipping to remove the excess parts.
    // Clipping is performed from the center of the eraser. This technique maintains the base of the eraser fixed at the center,
    // ensuring that the center portion remains static even if the skewAngle changes.
    canvas.clipRect(Rect.fromLTWH(-eraserWidth, 0, eraserHeight * 2, eraserHeight)); // clipping the rubber from center,

    // Draw the main body of the eraser

    canvas.drawRRect(RRect.fromRectXY(Rect.fromCenter(center: const Offset(0, 0), width: eraserWidth, height: eraserHeight), 7, 7), eraserBodyPaint);

    // Draw shadow on the eraser body
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromCenter(center: Offset(-strokeWidth, 0), width: 0.8 * strokeWidth, height: eraserHeight),
            bottomLeft: const Radius.circular(7), topLeft: const Radius.circular(7)),
        eraserBodyShadowPaint);

    // Draw the eraser holder
    canvas.drawRect(Rect.fromCenter(center: const Offset(0, 0), width: eraserWidth, height: eraserHolderHeight), eraserHolderPaint);
    // Draw lines on the eraser holder
    canvas.drawRect(Rect.fromCenter(center: Offset(0, eraserHolderHeight / 3), width: eraserWidth, height: 2), eraserHolderLinePaint);
    canvas.drawRect(Rect.fromCenter(center: Offset(0, eraserHolderHeight / 6), width: eraserWidth, height: 2), eraserHolderLinePaint);

    // Draw covers on the eraser holder
    canvas.drawRect(Rect.fromCenter(center: Offset(-strokeWidth, 0), width: 0.9 * strokeWidth, height: eraserHolderHeight), eraserHolderCoverPaint1);
    canvas.drawRect(Rect.fromCenter(center: const Offset(0, 0), width: strokeWidth, height: eraserHolderHeight), eraserHolderCoverPaint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
