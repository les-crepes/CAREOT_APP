import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class TopShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * -0.008196721);
    path_0.lineTo(size.width, size.height * -0.008196721);
    path_0.lineTo(size.width, size.height * 0.5081967);
    path_0.cubicTo(
        size.width * 0.8751556,
        size.height * 1.864770,
        size.width * 0.2228250,
        size.height * -0.1304489,
        0,
        size.height * 0.5081967);
    path_0.lineTo(0, size.height * -0.008196721);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.5000000, size.height * -0.8196721),
      Offset(size.width * 0.5000000, size.height * 0.9919213),
      [
        const Color(0xffFF9877).withOpacity(0.9),
        const Color(0xffFF9877).withOpacity(0.9),
        const Color(0xffFFBD70).withOpacity(1)
      ],
      [0, 0.0001, 1],
    );
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
