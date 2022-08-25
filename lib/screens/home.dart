import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';
import 'package:pdg_app/widgets/cards/pic_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ArrowPicCard(
          title: "Petit-déjeuner",
          subtitle: "8h30-9h00",
        ),
      ],
    );
  }
}
