//Add this CustomPaint widget to the Widget Tree
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.8275862);
    path_0.cubicTo(
        size.width * 0.8751556,
        size.height * 1.303167,
        size.width * 0.2228250,
        size.height * 0.6036954,
        0,
        size.height * 0.8275862);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, 0),
        Offset(size.width * 0.5000000, size.height * 0.9971667), [
      const Color(0xffFF9877).withOpacity(0.9),
      const Color(0xffFF9877).withOpacity(0.9),
      const Color(0xffFFBD70).withOpacity(1)
    ], [
      0,
      0.0001,
      1
    ]);
    canvas.drawPath(path_0, paint_0_fill);

    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
