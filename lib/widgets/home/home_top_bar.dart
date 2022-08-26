import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    Key? key,
    required this.background,
    required this.height,
  }) : super(key: key);

  final CustomPaint background;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      background,
      Container(
        // color: Colors.red,
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
            ),
            const SizedBox(height: 15),
            Text(
              "Hello Anna",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ]);
  }
}
