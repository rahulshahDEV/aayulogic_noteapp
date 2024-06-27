import 'package:flutter/material.dart';

class CurvedPlusButtonShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10); // Adjust for padding

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final radius = rect.width / 2; // Button will be a circle
    final center = rect.center;

    final double PI = 3.1415926535897932;

    final startAngle = PI / 4; // 45 degrees
    final sweepAngle = PI / 2; // 90 degrees (semicircle)

    return Path()
      ..moveTo(center.dx + radius, center.dy) // Start at right edge
      ..arcTo(rect, startAngle, sweepAngle, true) // Draw the arc
      ..lineTo(center.dx, center.dy) // Line back to center
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
