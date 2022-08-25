import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/main_card.dart';

class PicCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? subtitle;
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
          ),
          Container(
            child: icon,
          )
        ],
      ),
    ));
  }
}
