import 'package:flutter/material.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/straight_top_bar.dart';

class UpdateClientRecordScreen extends StatelessWidget {
  final User _user;

  const UpdateClientRecordScreen({required user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpdateClientRecord(
      clientFirstName: _user.firstName,
    );
  }
}

class UpdateClientRecord extends StatelessWidget {
  final String _clientFirstName;

  const UpdateClientRecord({required String clientFirstName, Key? key})
      : _clientFirstName = clientFirstName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StraightTopBar(title: "$_clientFirstName's record"),
        Expanded(
          child: ListView(padding: const EdgeInsets.all(16.0), children: [
            MainTextField(
                name: "BMI",
                icon: Icon(Icons.query_stats_outlined),
                keyboardType: TextInputType.number),
            const SizedBox(height: 15.0),
            MainTextField(
                name: "Weight",
                icon: Icon(Icons.monitor_weight_outlined),
                keyboardType: TextInputType.number),
            const SizedBox(height: 15.0),
            MainTextField(
                name: "Diagnosic", icon: Icon(Icons.recommend_outlined)),
            const SizedBox(height: 15.0),
            MainTextField(name: "Comments", icon: Icon(Icons.comment_outlined)),
            const SizedBox(height: 15.0),
            MainTextField(name: "Motivations", icon: Icon(Icons.favorite)),
            const SizedBox(height: 15.0),
            MainTextField(
                name: "Food objectives", icon: Icon(Icons.food_bank_outlined)),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Start date",
              icon: Icon(Icons.date_range),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "End date",
              icon: Icon(Icons.date_range),
              keyboardType: TextInputType.datetime,
            ),
          ]),
        ),
      ],
    );
  }
}
