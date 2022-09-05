import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/profile_avatar.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

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
    final isAdmin = context.read<AuthProvider>().isAdmin;
    ;

    return Stack(children: [
      background,
      Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileAvatar(image: AssetImage(clientPicturePath)),
            const SizedBox(height: 15),
            Text(
              !isAdmin ? "Hello $clientName" : "$clientName's diary",
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
