import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/ProfileAvatar.dart';
import 'package:pdg_app/widgets/profile/top_shape.dart';

import '../widgets/profile/profile_top_bar.dart';

class ProfileScreen extends StatelessWidget {
  final double _screenWidth;
  final String _clientPicturePath;

  const ProfileScreen({
    screenWidth = 0.0,
    clientPicturePath = 'assets/images/default_user_pic.png',
    Key? key,
  })  : _screenWidth = screenWidth,
        _clientPicturePath = clientPicturePath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        _screenWidth == 0 ? MediaQuery.of(context).size.width : _screenWidth;

    final height = (width * 0.46111111111111114).toDouble();

    return ProfileTopBar(
        width: width, height: height, clientPicturePath: _clientPicturePath);
  }
}
