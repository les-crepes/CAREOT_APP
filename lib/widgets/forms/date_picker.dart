import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/forms/main_text_field.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String _name;
  final void Function(DateTime?)? _onSelected;
  final DateTime? _initialDate;
  final Icon _icon;
  final DateTime? _firstDate;
  final DateTime? _lastDate;

  const DatePicker({
    required String name,
    void Function(DateTime?)? onSelected,
    DateTime? initialDate,
    required Icon icon,
    DateTime? firstDate,
    DateTime? lastDate,
    Key? key,
  })  : _name = name,
        _onSelected = onSelected,
        _initialDate = initialDate,
        _icon = icon,
        _firstDate = firstDate,
        _lastDate = lastDate,
        super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? picked;
  @override
  Widget build(BuildContext context) {
    final DateFormat hourFormatter = DateFormat("dd/MM/y");

    return GestureDetector(
      onTap: () async {
        DateTime? selected = await showDatePicker(
          context: context,
          initialDate: picked ?? widget._initialDate ?? DateTime.now(),
          firstDate: widget._firstDate ?? DateTime(2020, 01, 01),
          lastDate: widget._lastDate ?? DateTime(2050, 12, 31),
        );
        setState(() {
          picked = selected;
        });

        if (widget._onSelected != null) {
          widget._onSelected!(selected);
        }
      },
      child: MainTextField(
        name: picked != null
            ? hourFormatter.format(picked!)
            : widget._initialDate != null
                ? hourFormatter.format(widget._initialDate!)
                : widget._name,
        icon: widget._icon,
        enabled: false,
      ),
    );
  }
}
