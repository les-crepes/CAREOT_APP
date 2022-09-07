import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class ClientListTopShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * -1.885714);
    path_0.lineTo(size.width, size.height * -1.885714);
    path_0.lineTo(size.width, size.height);
    path_0.cubicTo(size.width * 0.6013889, size.height * 0.6508157,
        size.width * 0.3486111, size.height * 0.5717543, 0, size.height);
    path_0.lineTo(0, size.height * -1.885714);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.1166667, size.height * -162.4957),
        Offset(size.width * 0.9587444, size.height * -7.761914), [
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
