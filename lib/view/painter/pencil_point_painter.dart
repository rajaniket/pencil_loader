import 'dart:math';

import 'package:flutter/material.dart';

class PencilPointPainter extends CustomPainter {
  final double startAngle;
  final double strokeWidth;

  PencilPointPainter({
    this.startAngle = 0,
    this.strokeWidth = 12,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(radius, radius);

    Paint pencilPoint = Paint()
      ..color = const Color(0xFFF2B66C)
      ..style = PaintingStyle.fill;

    Paint pencilPointShadow = Paint()
      ..color = const Color(0xFFF78E0D)
      ..style = PaintingStyle.fill;

    Path trinaglePath = Path();

    double innerRadius = radius - 2.5 * strokeWidth;
    double outerRadius = radius + 0.5 * strokeWidth;
    double midRadius = radius - 0.5 * strokeWidth;

    Offset trianglePointA = center.translate(innerRadius * cos(startAngle), innerRadius * sin(startAngle));
    Offset trianglePointB = center.translate(outerRadius * cos(startAngle), outerRadius * sin(startAngle));
    Offset trianglePointC = center.translate(midRadius * cos(startAngle - pi / 10), midRadius * sin(startAngle - pi / 10));
    trinaglePath.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePath, pencilPoint);

    Path trinaglePathShadow = Path();
    double radiusForShadow = innerRadius + strokeWidth;
    trianglePointB = center.translate(radiusForShadow * cos(startAngle), radiusForShadow * sin(startAngle));
    trinaglePathShadow.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePathShadow, pencilPointShadow);

    Paint pencilPointDark = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    //saving the previous state in stack
    canvas.save();
    //cliping the black portion
    canvas.clipRect(Rect.fromCircle(center: trianglePointC, radius: strokeWidth));
    canvas.drawPath(trinaglePath, pencilPointDark);
    canvas.clipRect(Rect.fromCircle(center: trianglePointC, radius: 10));
    //poping the previous state from the stack
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
