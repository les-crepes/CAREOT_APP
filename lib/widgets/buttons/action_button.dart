import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;

  const ActionButton({
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                  spreadRadius: 0,
                ),
              ], shape: BoxShape.circle),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: (() => 1),
                elevation: 100,
                child: Icon(icon,
                    color: Theme.of(context).colorScheme.onPrimary, size: 35),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
