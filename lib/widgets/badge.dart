import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int _count;
  const Badge(
    int count, {
    Key? key,
  })  : _count = count,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          _count.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
