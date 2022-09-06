import 'package:flutter/material.dart';

import 'left_element_card.dart';

class PicCard extends StatelessWidget {
  final ImageProvider image;
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;

  const PicCard({
    required this.title,
    this.subtitle,
    required this.image,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeftElementCard(
      element: CircleAvatar(
        // backgroundImage: NetworkImage(imagePath),
        backgroundColor: Colors.white,
        radius: 66,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),

          // borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      title: title,
      subtitle: subtitle,
      icon: icon,
    );
  }
}
