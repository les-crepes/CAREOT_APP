import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';

class PicCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? subtitle;

  const PicCard({
    required this.title,
    this.subtitle,
    this.imagePath = "images/breakfast.jpg",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        child: Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/breakfast.jpg'),
            radius: 66,
          ),
          title: Text(title),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                )
              : const SizedBox(),
        ),
      ],
    ));
  }
}
