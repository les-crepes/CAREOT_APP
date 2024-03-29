import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/provider/aftercare_provider.dart';
import 'package:pdg_app/router/router.gr.dart';
import 'package:pdg_app/widgets/buttons/gradient_button.dart';
import 'package:pdg_app/widgets/custom_divider.dart';
import 'package:pdg_app/widgets/profile_template.dart';
import 'package:pdg_app/widgets/text_information.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/aftercare.dart';
import '../model/user.dart';

class ClientRecordScreen extends StatelessWidget {
  final User _user;

  const ClientRecordScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ChangeNotifierProvider(
        create: (context) => AftercareProvider(clientUid: _user.uid),
        builder: (context, child) {
          final afterCareProvider = context.watch<AftercareProvider>();
          log(afterCareProvider.aftercare.toString());
          final aftercareProvider = context.read<AftercareProvider>();
          return ClientRecord(
            defaultUserPic: 'assets/images/default_user_pic.png',
            clientPicturePath: _user.photoUrl,
            clientFirstName: _user.firstName,
            clientLastName: _user.lastName,
            clientEmail: _user.email,
            clientBirthday: _user.birthDate,
            clientPhone: _user.phoneNumber,
            clientInsurance: _user.avs,
            clientBmi: afterCareProvider.aftercare?.bmi ?? 0,
            clientWeight: afterCareProvider.aftercare?.weight ?? 0.0,
            clientComments: afterCareProvider.aftercare?.comments ?? '-',
            clientDiagnostic: afterCareProvider.aftercare?.diagnostic ?? '-',
            clientFoodObjectives:
                afterCareProvider.aftercare?.foodObjectives ?? '-',
            clientMotivations: afterCareProvider.aftercare?.motivations ?? '-',
            clientStartDate: afterCareProvider.aftercare?.startDate,
            clientEndDate: afterCareProvider.aftercare?.endDate,
            onIconButtonPressed: () async {
              final Aftercare? aftercare = await AutoRouter.of(context)
                  .push<Aftercare?>(UpdateClientRecordScreenRoute(
                      user: _user, aftercare: afterCareProvider.aftercare));

              if (aftercare != null) {
                if (aftercareProvider.aftercare != null) {
                  aftercareProvider.updateAftercare(aftercare);
                } else {
                  afterCareProvider.createAftercare(aftercare);
                }
              }
            },
            onDiariesButtonPressed: () {
              context.pushRoute(DiaryRouterPage(children: [
                DiaryScreenRoute(client: _user),
              ]));
            },
            onChatButtonPressed: () {
              AutoRouter.of(context).push(HomeScreenRoute(children: [
                ChatRouterPage(children: [ChatScreenRoute(otherUser: _user)])
              ]));
            },
          );
        },
      ),
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
  final int _bmi;
  final double _weight;
  final String _diagnostic;
  final String _comments;
  final String _motivations;
  final String _foodObjectives;
  final DateTime? _startDate;
  final DateTime? _endDate;
  final void Function()? _onIconButtonPressed;
  final String _defaultUserPic;
  final String? _clientPicturePath;
  final void Function()? _onDiariesButtonPressed;
  final void Function()? _onChatButtonPressed; //TODO décommenter

  const ClientRecord(
      {required clientFirstName,
      required clientLastName,
      required clientEmail,
      required clientPhone,
      required clientBirthday,
      required clientInsurance,
      clientBmi = 0,
      clientWeight = 0.0,
      clientDiagnostic = "-",
      clientComments = "-",
      clientMotivations = "-",
      clientFoodObjectives = "-",
      clientStartDate,
      clientEndDate,
      onIconButtonPressed,
      String? clientPicturePath,
      onDiariesButtonPressed,
      onChatButtonPressed,
      required String defaultUserPic,
      Key? key})
      : _clientFirstName = clientFirstName,
        _clientLastName = clientLastName,
        _clientEmail = clientEmail,
        _clientPhone = clientPhone,
        _clientBirthday = clientBirthday,
        _clientInsurance = clientInsurance,
        _bmi = clientBmi,
        _weight = clientWeight,
        _diagnostic = clientDiagnostic,
        _comments = clientComments,
        _motivations = clientMotivations,
        _foodObjectives = clientFoodObjectives,
        _startDate = clientStartDate,
        _endDate = clientEndDate,
        _onIconButtonPressed = onIconButtonPressed,
        _defaultUserPic = defaultUserPic,
        _clientPicturePath = clientPicturePath,
        _onDiariesButtonPressed = onDiariesButtonPressed,
        _onChatButtonPressed = onChatButtonPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat hourFormatter = DateFormat("d/M/y");

    return ProfileTemplate(
      clientFirstName: _clientFirstName,
      clientLastName: _clientLastName,
      clientEmail: _clientEmail,
      clientPhone: _clientPhone,
      clientBirthday: _clientBirthday,
      clientInsurance: _clientInsurance,
      buttonIcon: Icons.create_outlined,
      defaultUserPic: _defaultUserPic,
      clientPicturePath: _clientPicturePath,
      onIconButtonPressed: _onIconButtonPressed ?? () {},
      firstBloc: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GradientButton(
                color1: const Color(0xFFFFBD70),
                color2: const Color(0xFFFFBD70),
                onPress: _onDiariesButtonPressed,
                child: const Text(
                  "DIARIES",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              GradientButton(
                  color1: Theme.of(context).colorScheme.tertiary,
                  color2: Theme.of(context).colorScheme.tertiary,
                  onPress:
                      _onChatButtonPressed, // TODO changer pour sélectionner le bon chat.
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
      lastBloc: Column(
        children: [
          const CustomDivider(),
          TextInformation(label: 'BMI', text: _bmi.toString()),
          const SizedBox(height: 15),
          TextInformation(label: 'Weight', text: _weight.toString()),
          const SizedBox(height: 15),
          TextInformation(label: "Diagnostic", text: _diagnostic),
          const SizedBox(height: 15),
          TextInformation(label: 'Comments', text: _comments),
          const SizedBox(height: 15),
          TextInformation(label: 'Motivations', text: _motivations),
          const SizedBox(height: 15),
          TextInformation(label: 'Food Objectives', text: _foodObjectives),
          const SizedBox(height: 15),
          _startDate != null
              ? Column(
                  children: [
                    TextInformation(
                        label: 'Start date',
                        text: hourFormatter.format(_startDate!)),
                    const SizedBox(height: 15),
                  ],
                )
              : const SizedBox(),
          _endDate != null
              ? Column(
                  children: [
                    TextInformation(
                        label: 'End date',
                        text: hourFormatter.format(_endDate!)),
                    const SizedBox(height: 15),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
