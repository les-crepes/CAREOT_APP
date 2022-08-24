import 'dart:ui';

import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Color _color1;
  final Color _color2;
  final Widget? _child;
  final void Function()? _onPress;

  const GradientButton({
    Key? key,
    required Color color1,
    required Color color2,
    void Function()? onPress,
    Widget? child,
  })  : _color1 = color1,
        _color2 = color2,
        _onPress = onPress,
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 41.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[_color1, _color2]),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: _onPress,
            child: Center(
              child: _child,
            )),
      ),
    );
  }
}
