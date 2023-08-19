import 'dart:math';

import 'package:flutter/material.dart';

class PencilPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);
    double startAngle = 0;
    double swipeAngle = 4 * pi / 3;

    Paint pencilStrokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 12),
      -2 * pi / 3, // -120 degree
      4 * pi / 3, // how much to sweep from start angle // 240 degree
      false,
      pencilStrokePaint,
    );

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
      swipeAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody1,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 12),
      startAngle, // -120 degree
      swipeAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, // -120 degree
      swipeAngle, // how much to sweep from start angle // 240 degree
      false,
      pencilBody3,
    );

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

    double eraserAngleOffset = swipeAngle + pi / 20;
    Offset eraserCenter = center.translate((radius - 12) * cos(eraserAngleOffset), (radius - 12) * sin(eraserAngleOffset));
    canvas.save();
    canvas.translate(eraserCenter.dx, eraserCenter.dy); // new origin
    canvas.rotate(swipeAngle);
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
    canvas.restore(); // restored previouly saved state (it's a stack data structure)
    Paint pencilPoint = Paint()
      ..color = const Color(0xffFF7B96E)
      ..style = PaintingStyle.fill;
    Path trinaglePath = Path();
    Paint pencilPointShadow = Paint()
      ..color = Color(0xFFF78E0D)
      ..style = PaintingStyle.fill;

    canvas.save();

    // this is made up of points and points are dependent on angle so you don't need to rotate this

    Offset trianglePointA = center.translate((radius - 30) * cos(startAngle), (radius - 30) * sin(startAngle));
    Offset trianglePointB = center.translate((radius + 6) * cos(startAngle), (radius + 6) * sin(startAngle));
    double triangleAngleOffset = startAngle - pi / 10;
    Offset trianglePointC = center.translate((radius - 10) * cos(triangleAngleOffset), (radius - 10) * sin(triangleAngleOffset));
    trinaglePath.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePath, pencilPoint);
    Path trinaglePathShadow = Path();

    trianglePointB = center.translate((radius - 20) * cos(startAngle), (radius - 20) * sin(startAngle));
    trinaglePathShadow.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePathShadow, pencilPointShadow);

    Paint pencilPointDark = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    Path trinaglePathDark = Path();
    double darkTriangleAngleOffset1 = startAngle - pi / 10;
    double darkTriangleAngleOffset2 = startAngle - pi / 15;
    Offset darkTrianglePointA = center.translate((radius - 18) * cos(darkTriangleAngleOffset2), (radius - 18) * sin(darkTriangleAngleOffset2));
    Offset darkTrianglePointB = center.translate((radius - 6) * cos(darkTriangleAngleOffset2), (radius - 6) * sin(darkTriangleAngleOffset2));
    Offset darkTrianglePointC = center.translate((radius - 10) * cos(darkTriangleAngleOffset1), (radius - 10) * sin(darkTriangleAngleOffset1));
    trinaglePathDark.addPolygon([darkTrianglePointA, darkTrianglePointB, darkTrianglePointC], true);
    canvas.drawPath(trinaglePathDark, pencilPointDark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
