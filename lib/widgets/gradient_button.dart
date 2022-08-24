import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Color _color1;
  final Color _color2;
  final void Function()? _onPress;

  const GradientButton({
    Key? key,
    required Color color1,
    required Color color2,
    void Function()? onPress,
  })  : _color1 = color1,
        _color2 = color2,
        _onPress = onPress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
