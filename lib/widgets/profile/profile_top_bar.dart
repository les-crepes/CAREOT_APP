import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/profile/top_shape.dart';

import '../ProfileAvatar.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    Key? key,
    required this.width,
    required this.height,
    required String clientPicturePath,
  })  : _clientPicturePath = clientPicturePath,
        super(key: key);

  final double width;
  final double height;
  final String _clientPicturePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(width, height),
          painter: ProfileTopShape(),
        ),
        Container(
          alignment: Alignment.center,
          height: height + 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ProfileAvatar(image: AssetImage(_clientPicturePath)),
              const SizedBox(height: 8),
              Text(
                "Luca Coduri",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
