import 'package:flutter/material.dart';

import '../cards/main_card.dart';

class CustomIconButton extends StatelessWidget {
  final IconData _icon;
  final void Function()? _onTap;

  const CustomIconButton({
    Key? key,
    required IconData icon,
    void Function()? onTap,
  })  : _icon = icon,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: InkWell(
        onTap: _onTap,
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(_icon),
        ),
      ),
    );
  }
}
