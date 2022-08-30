import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/left_element_card.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';

import '../widgets/profile/profile_top_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Profile(
      clientFirstName: "Luca",
      clienLastName: "Coduri",
      nutriFirstName: "Claire",
      nutriLastName: "Nutri",
    );
  }
}

class Profile extends StatelessWidget {
  final double _screenWidth;
  final String _clientPicturePath;
  final String _clientFirstName;
  final String _clientLastName;
  final String _nutriFirstName;
  final String _nutriLastName;

  const Profile({
    screenWidth = 0.0,
    clientPicturePath = 'assets/images/default_user_pic.png',
    required clientFirstName,
    required clienLastName,
    required nutriFirstName,
    required nutriLastName,
    Key? key,
  })  : _screenWidth = screenWidth,
        _clientPicturePath = clientPicturePath,
        _clientFirstName = clientFirstName,
        _clientLastName = clienLastName,
        _nutriFirstName = nutriFirstName,
        _nutriLastName = nutriLastName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =
        _screenWidth == 0 ? MediaQuery.of(context).size.width : _screenWidth;

    final height = (width * 0.46111111111111114).toDouble();

    return Column(
      children: [
        ProfileTopBar(
          width: width,
          height: height,
          clientPicturePath: _clientPicturePath,
          clientFirstName: _clientFirstName,
          clientLastName: _clientLastName,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: LeftElementCard(
            title:
                Text("Your nutritionnist is $_nutriFirstName $_nutriLastName."),
            element: IconTheme(
              data: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              child: const Icon(Icons.notification_important_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
