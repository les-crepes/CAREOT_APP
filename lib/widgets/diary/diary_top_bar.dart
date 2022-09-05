import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/profile_avatar.dart';

class DiaryTopBar extends StatelessWidget {
  const DiaryTopBar({
    Key? key,
    required this.background,
    required this.height,
    required this.clientName,
    required this.clientPicturePath,
    required this.defaultUserPic,
  }) : super(key: key);

  final CustomPaint background;
  final double height;
  final String clientName;
  final String? clientPicturePath;
  final String defaultUserPic;

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
            clientPicturePath != null
                ? ProfileAvatar(image: NetworkImage(clientPicturePath!))
                : ProfileAvatar(image: AssetImage(defaultUserPic)),
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
