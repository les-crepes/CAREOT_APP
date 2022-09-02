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

import '../model/user.dart';

class ClientRecordScreen extends StatelessWidget {
  final User _user;

  const ClientRecordScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AftercareProvider(clientUid: _user.uid),
      builder: (context, child) {
        final afterCareProvider = context.watch<AftercareProvider>();
        return ClientRecord(
          clientFirstName: _user.firstName,
          clientLastName: _user.lastName,
          clientEmail: "email", //TODO
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
          onIconButtonPressed: () => AutoRouter.of(context)
              .push(UpdateClientRecordScreenRoute(user: _user)),
        );
      },
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
      onIconButtonPressed: _onIconButtonPressed ?? () {},
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
