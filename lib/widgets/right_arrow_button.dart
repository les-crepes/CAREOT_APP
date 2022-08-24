import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/gradient_button.dart';

class RightArrowButton extends StatelessWidget {
  final String _text;

  const RightArrowButton({Key? key, required String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      color1: const Color(0xFFFFBD70),
      color2: const Color(0xFFFF9877),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Text(_text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          Icon(
            Icons.keyboard_arrow_right_sharp,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 40,
          )
        ],
      ),
    );
  }
}
