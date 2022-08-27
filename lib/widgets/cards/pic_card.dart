import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';

class PicCard extends StatelessWidget {
  final String imagePath;
  final Widget title;
  final Widget? subtitle;
  final Icon? icon;

  const PicCard({
    required this.title,
    this.subtitle,
    this.imagePath = "images/breakfast.jpg",
    this.icon,
    Key? key,
  }) : super(key: key);

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
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/breakfast.jpg'),
                radius: 66,
              ),
              title: title,
              subtitle: subtitle != null ? subtitle! : const SizedBox(),
            ),
          ),
          Container(
            child: icon,
          )
        ],
      ),
    ));
  }
}
