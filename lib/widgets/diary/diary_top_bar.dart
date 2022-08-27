import 'package:flutter/material.dart';

class DiaryTopBar extends StatelessWidget {
  const DiaryTopBar({
    Key? key,
    required this.background,
    required this.height,
    required this.clientName,
    required this.clientPicturePath,
  }) : super(key: key);

  final CustomPaint background;
  final double height;
  final String clientName;
  final String clientPicturePath;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      background,
      Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                )
              ], shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundImage: AssetImage(clientPicturePath),
                backgroundColor: Colors.white,
                radius: 45,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Hello $clientName",
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
