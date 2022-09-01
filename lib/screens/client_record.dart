import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/buttons/gradient_button.dart';
import 'package:pdg_app/widgets/profile_template.dart';

import '../model/user.dart';

class ClientRecordScreen extends StatelessWidget {
  final User _user;

  const ClientRecordScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClientRecord(
      clientFirstName: _user.firstName,
      clientLastName: _user.lastName,
      clientEmail: "email", //TODO
      clientBirthday: _user.birthDate,
      clientPhone: _user.phoneNumber,
      clientInsurance: _user.avs,
    );
  }
}

class ClientRecord extends StatelessWidget {
  final String _clientFirstName;
  final String _clientLastName;
  final String _clientEmail;
  final String _clientPhone;
  final DateTime _clientBirthday;
  final String _clientInsurance;

  const ClientRecord(
      {required clientFirstName,
      required clientLastName,
      required clientEmail,
      required clientPhone,
      required clientBirthday,
      required clientInsurance,
      Key? key})
      : _clientFirstName = clientFirstName,
        _clientLastName = clientLastName,
        _clientEmail = clientEmail,
        _clientPhone = clientPhone,
        _clientBirthday = clientBirthday,
        _clientInsurance = clientInsurance,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileTemplate(
      clientFirstName: _clientFirstName,
      clientLastName: _clientLastName,
      clientEmail: _clientEmail,
      clientPhone: _clientPhone,
      clientBirthday: _clientBirthday,
      clientInsurance: _clientInsurance,
      firstBloc: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GradientButton(
                color1: const Color(0xFFFFBD70),
                color2: const Color(0xFFFFBD70),
                onPress: (() => AutoRouter.of(context).push(
                    const DiaryScreenRoute())), //TODO changer pour sélectionner bon calendrier
                child: const Text(
                  "DIARIES",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              GradientButton(
                  color1: Theme.of(context).colorScheme.tertiary,
                  color2: Theme.of(context).colorScheme.tertiary,
                  onPress: (() => AutoRouter.of(context).push(
                      const ChatScreenRoute())), //TODO pour sélectionner bonne discussion
                  child: const Text(
                    "CHAT",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
