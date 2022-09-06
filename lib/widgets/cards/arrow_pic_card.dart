import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';

class ArrowPicCard extends StatelessWidget {
  final ImageProvider? image;
  final Widget title;
  final Widget? subtitle;
  final ImageProvider defaultUserPic;

  const ArrowPicCard({
    required this.title,
    this.subtitle,
    this.image,
    required this.defaultUserPic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicCard(
      title: title,
      subtitle: subtitle,
      image: image ?? defaultUserPic,
      icon: const Icon(Icons.keyboard_arrow_right_sharp),
    );
  }
}
