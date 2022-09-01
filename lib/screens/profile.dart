import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/widgets/cards/left_element_card.dart';
import 'package:pdg_app/widgets/text_information.dart';
import 'package:intl/intl.dart';
import '../router/router.gr.dart';
import '../widgets/buttons/custom_icon_button.dart';
import '../widgets/profile/profile_top_bar.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/model/dietitian.dart';

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
      nutriFirstName: "Claire", // TODO
      nutriLastName: "Nutri", // TODO
      clientEmail: "luca.coduri@gmail.com", //TODO
      clientPhone: user.phoneNumber,
      clientBirthday: user.birthDate,
      clientInsurance: user.avs,
      onLogoutPressed: () {
        authProvider.signOut();
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
    final width =
        _screenWidth == 0 ? MediaQuery.of(context).size.width : _screenWidth;

    final height = (width * 0.46111111111111114).toDouble();

    final DateFormat hourFormatter = DateFormat("d/M/y");

    return Column(
      children: [
        ProfileTopBar(
          width: width,
          height: height,
          clientPicturePath: _clientPicturePath,
          clientFirstName: _clientFirstName,
          clientLastName: _clientLastName,
          onLogOutPress: _onLogoutPressed,
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              LeftElementCard(
                title: Text(
                    "Your nutritionnist is $_nutriFirstName $_nutriLastName."),
                element: IconTheme(
                  data: IconThemeData(
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  child: const Icon(Icons.notification_important_outlined),
                ),
              ),
              Divider(
                height: 60,
                thickness: 1,
                indent: 40,
                endIndent: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Text("Personal datas",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextInformation(label: "Email", text: _clientEmail),
                      const SizedBox(height: 15),
                      TextInformation(label: "Phone", text: _clientPhone),
                      const SizedBox(height: 15),
                      TextInformation(
                          label: "Birthday",
                          text: hourFormatter.format(_clientBirthday)),
                      const SizedBox(height: 15),
                      TextInformation(
                          label: "Insurance", text: _clientInsurance),
                      const SizedBox(height: 15),
                    ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
