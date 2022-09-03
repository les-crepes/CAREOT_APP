import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/widgets/cards/left_element_card.dart';
import 'package:pdg_app/widgets/profile_template.dart';
import '../router/router.gr.dart';
import '../widgets/buttons/custom_icon_button.dart';
import '../widgets/profile/profile_top_bar.dart';
import '../widgets/custom_divider.dart';

import '../provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // IDietitian dietitianApi = FirebaseDietitian(FirebaseFirestore.instance);

  // Dietitian dietitian = await dietitianApi.readDietitian("bZB6G7LbLSfp8lTPsh00fWxiHb03");

  @override
  Widget build(BuildContext context) {
    final authProvider = GetIt.I.get<AuthProvider>();
    final User? user = authProvider.user;

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("An error has occured."),
            CustomIconButton(
              icon: Icons.logout_outlined,
              onTap: () {
                authProvider.signOut();
                AutoRouter.of(context).navigate(const LoginScreenRoute());
              },
            )
          ],
        ),
      );
    }

    return Profile(
      clientFirstName: user.firstName,
      clienLastName: user.lastName,
      blockEnabled: !authProvider.isAdmin,
      blockText: authProvider.clientDietitian == null
          ? "Yous nutritionnist hasn't contact you yet."
          : "Your nutritionnist is ${authProvider.clientDietitian!.firstName} ${authProvider.clientDietitian!.lastName}.",
      clientEmail: user.email,
      clientPhone: user.phoneNumber,
      clientBirthday: user.birthDate,
      clientInsurance: user.avs,
      onLogoutPressed: () {
        GetIt.I.get<AuthProvider>().signOut();
        context.router.replaceAll([
          const LoginScreenRoute(),
        ]);
      },
    );
  }
}

class Profile extends StatelessWidget {
  final double _screenWidth;
  final String _clientPicturePath;
  final String _clientFirstName;
  final String _clientLastName;
  final bool _blockEnabled;
  final String _blocText;
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
    required clientEmail,
    required clientPhone,
    required clientBirthday,
    required clientInsurance,
    blockEnabled = false,
    blockText = "",
    void Function()? onLogoutPressed,
    Key? key,
  })  : _screenWidth = screenWidth,
        _clientPicturePath = clientPicturePath,
        _clientFirstName = clientFirstName,
        _clientLastName = clienLastName,
        _blocText = blockText,
        _blockEnabled = blockEnabled,
        _clientEmail = clientEmail,
        _clientPhone = clientPhone,
        _clientBirthday = clientBirthday,
        _clientInsurance = clientInsurance,
        _onLogoutPressed = onLogoutPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
        screenWidth: _screenWidth,
        clientPicturePath: _clientPicturePath,
        clientFirstName: _clientFirstName,
        clientLastName: _clientLastName,
        clientEmail: _clientEmail,
        clientPhone: _clientPhone,
        clientBirthday: _clientBirthday,
        clientInsurance: _clientInsurance,
        onIconButtonPressed: _onLogoutPressed,
        buttonIcon: Icons.logout_outlined,
        firstBloc: Column(children: [
          _blockEnabled
              ? Column(
                  children: [
                    LeftElementCard(
                      title: Text(_blocText),
                      element: IconTheme(
                        data: IconThemeData(
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        child:
                            const Icon(Icons.notification_important_outlined),
                      ),
                    ),
                    const CustomDivider(),
                  ],
                )
              : const SizedBox(),
          const Text("Personal data",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const SizedBox(height: 15),
        ]));
  }
}
