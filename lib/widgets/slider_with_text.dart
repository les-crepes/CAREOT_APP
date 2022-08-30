import 'package:flutter/material.dart';

import 'cards/main_card.dart';

class SliderWithText extends StatelessWidget {
  const SliderWithText({
    Key? key,
    required this.context,
    required this.text,
    required this.value,
    required this.onChanged,
    required this.labels,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final double value;
  final void Function(double p1)? onChanged;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return MainCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 10, 13, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.local_dining),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: const Color(0xFF5B5B5B), fontSize: 15),
                ),
              ],
            ),
          ),
          Slider(
            value: value,
            onChanged: onChanged,
            divisions: labels.length - 1,
            label: labels[value.floor()],
            min: 0,
            max: labels.length.toDouble() - 1,
          ),
        ],
      ),
    );
  }
}
