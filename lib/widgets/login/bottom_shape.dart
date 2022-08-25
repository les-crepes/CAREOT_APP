import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BottomShape extends CustomPainter {
  const BottomShape();

  @override
  void paint(Canvas canvas, Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.06011038);
    path0.cubicTo(
        size.width * 0.3972222,
        size.height * 0.7978142,
        size.width * 0.5722222,
        size.height * -0.2404372,
        size.width,
        size.height * 0.06011038);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, size.height * 0.06011038);
    path0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.5000000, size.height * 0.3909918),
      Offset(size.width * 0.5000000, size.height),
      [
        const Color(0xffFFBD70).withOpacity(1),
        const Color(0xffFF9877).withOpacity(0.9)
      ],
      [0, 1],
    );
    canvas.drawPath(path0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
