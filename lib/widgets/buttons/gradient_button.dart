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
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          gradient: LinearGradient(colors: <Color>[_color1, _color2]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(64),
              offset: const Offset(0.0, 5),
              blurRadius: 15,
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
