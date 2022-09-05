import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';

class ArrowPicCard extends StatelessWidget {
  final String imagePath;
  final Widget title;
  final Widget? subtitle;

  const ArrowPicCard({
    required this.title,
    this.subtitle,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicCard(
      title: title,
      subtitle: subtitle,
      imagePath: imagePath,
      icon: const Icon(Icons.keyboard_arrow_right_sharp),
    );
  }
}
