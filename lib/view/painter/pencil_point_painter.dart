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
      ..color = const Color(0xFFF7B96E)
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
    Offset trianglePointC = center.translate(midRadius * cos(startAngle - pi / 9), midRadius * sin(startAngle - pi / 9));
    trinaglePath.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePath, pencilPoint);
    //drawing nib shadow
    Path trinaglePathShadow = Path();
    double radiusForShadow = innerRadius + strokeWidth;
    trianglePointB = center.translate(radiusForShadow * cos(startAngle), radiusForShadow * sin(startAngle));
    trinaglePathShadow.addPolygon([trianglePointA, trianglePointB, trianglePointC], true);
    canvas.drawPath(trinaglePathShadow, pencilPointShadow);
    // drawing nib
    Paint pencilPointDark = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    //saving the previous state in stack
    canvas.save();
    //cliping the black portion
    canvas.clipRect(Rect.fromCircle(center: trianglePointC, radius: strokeWidth));
    canvas.drawPath(trinaglePath, pencilPointDark);
    //poping the previous state from the stack
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
