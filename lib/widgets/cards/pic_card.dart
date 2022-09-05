import 'package:flutter/material.dart';

import 'left_element_card.dart';

class PicCard extends StatelessWidget {
  final String imagePath;
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;

  const PicCard({
    required this.title,
    this.subtitle,
    required this.imagePath,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeftElementCard(
      element: CircleAvatar(
        backgroundImage: NetworkImage(imagePath),
        backgroundColor: Colors.white,
        radius: 66,
      ),
      title: title,
      subtitle: subtitle,
      icon: icon,
    );
  }
}
