import 'package:auto_route/auto_route.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class TimePickerDialog extends StatelessWidget {
  const TimePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return createInlinePicker(
        value: TimeOfDay.now(),
        onChange: (time) {
          context.router.pop(time);
        },
        onCancel: () => context.router.pop(),
        is24HrFormat: true,
        blurredBackground: true);
  }
}
