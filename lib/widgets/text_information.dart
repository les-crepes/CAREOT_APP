import 'package:flutter/material.dart';

class TextInformation extends StatelessWidget {
  final String _label;
  final String _text;

  const TextInformation({required label, required text, Key? key})
      : _label = label,
        _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _label,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black38,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _text,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
