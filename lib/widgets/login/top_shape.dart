import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TopShape extends CustomPainter {
  const TopShape();

  @override
  void paint(Canvas canvas, Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.8275862);
    path0.cubicTo(
        size.width * 0.8751556,
        size.height * 1.303167,
        size.width * 0.2228250,
        size.height * 0.6036954,
        0,
        size.height * 0.8275862);
    path0.lineTo(0, 0);
    path0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.5000000, 0),
      Offset(size.width * 0.5000000, size.height * 0.9971667),
      [
        const Color(0xffFF9877).withOpacity(0.9),
        const Color(0xffFF9877).withOpacity(0.9),
        const Color(0xffFFBD70).withOpacity(1)
      ],
      [0, 0.0001, 1],
    );
    canvas.drawPath(path0, paint0Fill);

    canvas.drawPath(path0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
