import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/widgets/cards/left_element_card.dart';
import 'package:pdg_app/widgets/profile_template.dart';
import 'package:pdg_app/widgets/text_information.dart';
import 'package:intl/intl.dart';
import '../router/router.gr.dart';
import '../widgets/profile/profile_top_bar.dart';

import '../provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Profile(
      clientFirstName: "Luca",
      clienLastName: "Coduri",
      nutriFirstName: "Claire",
      nutriLastName: "Nutri",
      clientEmail: "luca.coduri@gmail.com",
      clientPhone: "0794563418",
      clientBirthday: DateTime(1996, 12, 18),
      clientInsurance: "09734789789248943",
      onLogoutPressed: () {
        GetIt.I.get<AuthProvider>().signOut();
        AutoRouter.of(context).navigate(const LoginScreenRoute());
      },
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
  final String _clientEmail;
  final String _clientPhone;
  final DateTime _clientBirthday;
  final String _clientInsurance;
  final void Function()? _onLogoutPressed;

  const Profile({
    screenWidth = 0.0,
    clientPicturePath = 'assets/images/default_user_pic.png',
    required clientFirstName,
    required clienLastName,
    required nutriFirstName,
    required nutriLastName,
    required clientEmail,
    required clientPhone,
    required clientBirthday,
    required clientInsurance,
    void Function()? onLogoutPressed,
    Key? key,
  })  : _screenWidth = screenWidth,
        _clientPicturePath = clientPicturePath,
        _clientFirstName = clientFirstName,
        _clientLastName = clienLastName,
        _nutriFirstName = nutriFirstName,
        _nutriLastName = nutriLastName,
        _clientEmail = clientEmail,
        _clientPhone = clientPhone,
        _clientBirthday = clientBirthday,
        _clientInsurance = clientInsurance,
        _onLogoutPressed = onLogoutPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      clientFirstName: _clientFirstName,
      clientLastName: _clientLastName,
      nutriFirstName: _nutriFirstName,
      nutriLastName: _nutriLastName,
      clientEmail: _clientEmail,
      clientPhone: _clientPhone,
      clientBirthday: _clientBirthday,
      clientInsurance: _clientInsurance,
    );
  }
}
