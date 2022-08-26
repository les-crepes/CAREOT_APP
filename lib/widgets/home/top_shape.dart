import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HomeTopShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.cubicTo(size.width * 0.6013889, size.height * 0.8789954,
        size.width * 0.3486111, size.height * 0.8515991, 0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.1166667, size.height * 0.09036129),
        Offset(size.width * 0.9716639, size.height * 0.5621290), [
      const Color(0xffFFBD70).withOpacity(1),
      const Color(0xffFF9877).withOpacity(0.9)
    ], [
      0,
      1
    ]);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
