import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 01, 01),
        lastDate: DateTime(2050, 12, 31),
      ),
      child: MainTextField(name: "Test", icon: Icon(Icons.date_range)),
    );
  }
}
