import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class BottomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1301861);
    path_0.cubicTo(
        size.width * 0.3972222,
        size.height * 1.839051,
        size.width * 0.5722222,
        size.height * -0.5660190,
        size.width,
        size.height * 0.1301861);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.1301861);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.5000000, 0),
      Offset(size.width * 0.5000000, size.height),
      [
        const Color(0xffFFBD70).withOpacity(1),
        const Color(0xffFF9877).withOpacity(0.9)
      ],
      [0, 1],
    );
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
