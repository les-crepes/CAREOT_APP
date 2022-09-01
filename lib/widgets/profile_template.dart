import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/text_information.dart';

import 'cards/left_element_card.dart';
import 'profile/profile_top_bar.dart';
import 'package:intl/intl.dart';

class ProfileTemplate extends StatelessWidget {
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
  final void Function()? _onIconButtonPressed;
  final IconData? _buttonIcon;
  final Widget? _firstBloc;
  final Widget? _lastBloc;

  const ProfileTemplate(
      {screenWidth = 0.0,
      clientPicturePath = 'assets/images/default_user_pic.png',
      required clientFirstName,
      required clientLastName,
      required nutriFirstName,
      required nutriLastName,
      required clientEmail,
      required clientPhone,
      required clientBirthday,
      required clientInsurance,
      void Function()? onIconButtonPressed,
      buttonIcon,
      firstBloc,
      lastBloc,
      Key? key})
      : _screenWidth = screenWidth,
        _clientPicturePath = clientPicturePath,
        _clientFirstName = clientFirstName,
        _clientLastName = clientLastName,
        _nutriFirstName = nutriFirstName,
        _nutriLastName = nutriLastName,
        _clientEmail = clientEmail,
        _clientPhone = clientPhone,
        _clientBirthday = clientBirthday,
        _clientInsurance = clientInsurance,
        _onIconButtonPressed = onIconButtonPressed,
        _buttonIcon = buttonIcon,
        _firstBloc = firstBloc,
        _lastBloc = lastBloc,
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
          onIconButtonPress: _onIconButtonPressed,
          buttonIcon: _buttonIcon,
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _firstBloc ?? const SizedBox(),
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
              ),
              _lastBloc ?? const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
