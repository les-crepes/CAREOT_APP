import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/provider/aftercare_provider.dart';
import 'package:pdg_app/widgets/buttons/action_button.dart';
import 'package:pdg_app/widgets/forms/date_picker.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:pdg_app/widgets/straight_top_bar.dart';
import 'package:provider/provider.dart';

class UpdateClientRecordScreen extends StatefulWidget {
  final User _user;
  final Aftercare? _aftercare;

  UpdateClientRecordScreen({
    required user,
    Aftercare? aftercare,
    Key? key,
  })  : _user = user,
        _aftercare = aftercare,
        super(key: key);

  @override
  State<UpdateClientRecordScreen> createState() =>
      _UpdateClientRecordScreenState();
}

class _UpdateClientRecordScreenState extends State<UpdateClientRecordScreen> {
  final TextEditingController _bmiController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _diagnosticController = TextEditingController();

  final TextEditingController _commentsController = TextEditingController();

  final TextEditingController _motivationsController = TextEditingController();

  final TextEditingController _foodObjectivesController =
      TextEditingController();

  DateTime? _selectedStartDate;

  DateTime? _selectedEndTime;

  @override
  void initState() {
    if (widget._aftercare != null) {
      if (widget._aftercare!.bmi != null) {
        _bmiController.text = widget._aftercare!.bmi.toString();
      }
      if (widget._aftercare!.weight != null) {
        _weightController.text = widget._aftercare!.weight.toString();
      }
      if (widget._aftercare!.diagnostic != null) {
        _diagnosticController.text = widget._aftercare!.diagnostic!;
      }
      if (widget._aftercare!.comments != null) {
        _commentsController.text = widget._aftercare!.comments!;
      }
      if (widget._aftercare!.motivations != null) {
        _motivationsController.text = widget._aftercare!.motivations!;
      }
      if (widget._aftercare!.foodObjectives != null) {
        _foodObjectivesController.text = widget._aftercare!.foodObjectives!;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateClientRecord(
      clientFirstName: widget._user.firstName,
      bmiController: _bmiController,
      bmiInitial: widget._aftercare?.bmi,
      weightController: _weightController,
      diagnosticController: _diagnosticController,
      commentsController: _commentsController,
      motivationsController: _motivationsController,
      foodObjectivesController: _foodObjectivesController,
      onSelectedStartDate: (date) {
        _selectedStartDate = date;
      },
      onSelectedEndDate: (date) {
        _selectedEndTime = date;
      },
      initialStartTime: widget._aftercare?.startDate,
      initialEndTime: widget._aftercare?.endDate,
      onValidatePressed: () {
        if (_selectedStartDate != null) {
          AutoRouter.of(context).pop(Aftercare(
            clientId: widget._user.uid,
            bmi: int.parse(_bmiController.text),
            weight: double.parse(_weightController.text),
            diagnostic: _diagnosticController.text,
            comments: _commentsController.text,
            foodObjectives: _foodObjectivesController.text,
            motivations: _motivationsController.text,
            startDate: _selectedStartDate!,
            endDate: _selectedEndTime,
          ));
        }
      },
    );
  }
}

class UpdateClientRecord extends StatelessWidget {
  final String _clientFirstName;
  final TextEditingController? _bmiController;
  final int? _bmiInitial;
  final TextEditingController? _weightController;
  final TextEditingController? _diagnosticController;
  final TextEditingController? _commentsController;
  final TextEditingController? _motivationsController;
  final TextEditingController? _foodObjectivesController;
  final void Function(DateTime?)? _onSelectedStartDate;
  final DateTime? _initialStartTime;
  final DateTime? _initialEndTime;
  final void Function(DateTime?)? _onSelectedEndDate;
  final void Function()? _onValidatePressed;

  const UpdateClientRecord({
    required String clientFirstName,
    TextEditingController? bmiController,
    int? bmiInitial,
    TextEditingController? weightController,
    TextEditingController? diagnosticController,
    TextEditingController? commentsController,
    TextEditingController? motivationsController,
    TextEditingController? foodObjectivesController,
    void Function(DateTime?)? onSelectedStartDate,
    void Function(DateTime?)? onSelectedEndDate,
    DateTime? initialStartTime,
    DateTime? initialEndTime,
    void Function()? onValidatePressed,
    Key? key,
  })  : _clientFirstName = clientFirstName,
        _bmiController = bmiController,
        _bmiInitial = bmiInitial,
        _weightController = weightController,
        _diagnosticController = diagnosticController,
        _commentsController = commentsController,
        _motivationsController = motivationsController,
        _foodObjectivesController = foodObjectivesController,
        _onSelectedStartDate = onSelectedStartDate,
        _onSelectedEndDate = onSelectedEndDate,
        _initialStartTime = initialStartTime,
        _initialEndTime = initialEndTime,
        _onValidatePressed = onValidatePressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          StraightTopBar(title: "$_clientFirstName's record"),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              MainTextField(
                  name: "BMI",
                  icon: const Icon(Icons.query_stats_outlined),
                  keyboardType: TextInputType.number,
                  controller: _bmiController,
                  initialValue: _bmiInitial?.toString()),
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
                initialDate: _initialStartTime,
              ),
              const SizedBox(height: 15.0),
              DatePicker(
                name: "End date",
                onSelected: _onSelectedEndDate,
                initialDate: _initialEndTime,
              ),
            ]),
          ),
        ],
      ),
      ActionButton(
        icon: Icons.check,
        onPressed: _onValidatePressed,
      ),
    ]);
  }
}
