import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 60,
      thickness: 1,
      indent: 40,
      endIndent: 40,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
