import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';

import 'left_element_card.dart';

class PicCard extends StatelessWidget {
  final String imagePath;
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;

  const PicCard({
    required this.title,
    this.subtitle,
    this.imagePath = 'assets/images/breakfast.jpg',
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeftElementCard(
      element: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 66,
      ),
      title: title,
      subtitle: subtitle,
      icon: icon,
    );
  }
}
