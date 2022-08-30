import 'package:flutter/material.dart';

import 'main_card.dart';

class LeftElementCard extends StatelessWidget {
  final Widget _element;
  final Widget _title;
  final Widget? _subtitle;
  final Icon? _icon;

  const LeftElementCard({
    Key? key,
    required element,
    required title,
    subtitle,
    icon,
  })  : _element = element,
        _title = title,
        _subtitle = subtitle,
        _icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0),
              leading: _element,
              title: _title,
              subtitle: _subtitle != null ? _subtitle! : const SizedBox(),
            ),
          ),
          Container(
            child: _icon,
          )
        ],
      ),
    ));
  }
}
