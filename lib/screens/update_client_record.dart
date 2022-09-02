import 'package:flutter/material.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/widgets/forms/date_picker.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/straight_top_bar.dart';

class UpdateClientRecordScreen extends StatelessWidget {
  final User _user;
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _diagnosticController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _motivationsController = TextEditingController();
  final TextEditingController _foodObjectivesController =
      TextEditingController();
  DateTime? _selectedStartDate;
  DateTime? _selectedEndTime;

  UpdateClientRecordScreen({required user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpdateClientRecord(
      clientFirstName: _user.firstName,
      onSelectedStartDate: (date) {
        _selectedStartDate = date;
      },
      onSelectedEndDate: (date) {
        _selectedEndTime = date;
      },
    );
  }
}

class UpdateClientRecord extends StatelessWidget {
  final String _clientFirstName;
  final TextEditingController? _bmiController;
  final TextEditingController? _weightController;
  final TextEditingController? _diagnosticController;
  final TextEditingController? _commentsController;
  final TextEditingController? _motivationsController;
  final TextEditingController? _foodObjectivesController;
  final void Function(DateTime?)? _onSelectedStartDate;
  final void Function(DateTime?)? _onSelectedEndDate;

  const UpdateClientRecord({
    required String clientFirstName,
    TextEditingController? bmiController,
    TextEditingController? weightController,
    TextEditingController? diagnosticController,
    TextEditingController? commentsController,
    TextEditingController? motivationsController,
    TextEditingController? foodObjectivesController,
    void Function(DateTime?)? onSelectedStartDate,
    void Function(DateTime?)? onSelectedEndDate,
    Key? key,
  })  : _clientFirstName = clientFirstName,
        _bmiController = bmiController,
        _weightController = weightController,
        _diagnosticController = diagnosticController,
        _commentsController = commentsController,
        _motivationsController = motivationsController,
        _foodObjectivesController = foodObjectivesController,
        _onSelectedStartDate = onSelectedStartDate,
        _onSelectedEndDate = onSelectedEndDate,
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
                icon: const Icon(Icons.query_stats_outlined),
                keyboardType: TextInputType.number,
                controller: _bmiController),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Weight",
              icon: const Icon(Icons.monitor_weight_outlined),
              keyboardType: TextInputType.number,
              controller: _weightController,
            ),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Diagnosic",
              icon: const Icon(Icons.recommend_outlined),
              controller: _diagnosticController,
            ),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Comments",
              icon: const Icon(Icons.comment_outlined),
              controller: _commentsController,
            ),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Motivations",
              icon: const Icon(Icons.favorite),
              controller: _motivationsController,
            ),
            const SizedBox(height: 15.0),
            MainTextField(
              name: "Food objectives",
              icon: const Icon(Icons.food_bank_outlined),
              controller: _foodObjectivesController,
            ),
            const SizedBox(height: 15.0),
            DatePicker(
              name: "Start date",
              onSelected: _onSelectedStartDate,
            ),
            const SizedBox(height: 15.0),
            DatePicker(
              name: "End date",
              onSelected: _onSelectedEndDate,
            ),
          ]),
        ),
      ],
    );
  }
}
