import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final AssetImage image;

  const ProfileAvatar({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ], shape: BoxShape.circle),
        child: CircleAvatar(
          backgroundImage: image,
          backgroundColor: Colors.white,
          radius: 45,
        ));
  }
}
