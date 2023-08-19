import 'dart:math';

import 'package:flutter/material.dart';

class PencilPointPainter extends CustomPainter {
  final double startAngle;

  PencilPointPainter({this.startAngle = 0});
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);

    Paint pencilPoint = Paint()
      ..color = Color(0xFFF2B66C)
      ..style = PaintingStyle.fill;

    Paint pencilPointShadow = Paint()
      ..color = const Color(0xFFF78E0D)
      ..style = PaintingStyle.fill;

    Path trinaglePath = Path();

    Offset trianglePointA = center.translate((radius - 30) * cos(startAngle), (radius - 30) * sin(startAngle));
    Offset trianglePointB = center.translate((radius + 6) * cos(startAngle), (radius + 6) * sin(startAngle));
    Offset trianglePointC = center.translate((radius - 10) * cos(startAngle - pi / 10), (radius - 10) * sin(startAngle - pi / 10));
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
    trianglePointA = center.translate((radius - 18) * cos(darkTriangleAngleOffset2), (radius - 18) * sin(darkTriangleAngleOffset2));
    trianglePointB = center.translate((radius - 6) * cos(darkTriangleAngleOffset2), (radius - 6) * sin(darkTriangleAngleOffset2));
    trianglePointC = center.translate((radius - 10) * cos(darkTriangleAngleOffset1), (radius - 10) * sin(darkTriangleAngleOffset1));
    trinaglePathDark.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePathDark, pencilPointDark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
