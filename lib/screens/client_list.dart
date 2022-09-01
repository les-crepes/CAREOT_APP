import 'package:flutter/material.dart';
import 'package:pdg_app/widgets/cards/arrow_pic_card.dart';

import '../model/client.dart';
import '../widgets/client_list.dart/top_shape.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClientList();
  }
}

class ClientList extends StatelessWidget {
  final double _screenWidth;

  ClientList({
    screenWidth = 0.0,
    Key? key,
  })  : _screenWidth = screenWidth,
        super(key: key);

  final List<Client> clients = [
    Client(
      firstName: "Nelson",
      lastName: "Jeanrenaud",
      birthDate: DateTime(2001, 09, 01),
      insurance: "8979279728973912",
      phoneNumber: "0798746756",
    )
  ];

  @override
  Widget build(BuildContext context) {
    final width =
        _screenWidth == 0 ? MediaQuery.of(context).size.width : _screenWidth;

    final height = (width * 0.19444444444444445).toDouble();

    return Column(
      children: [
        CustomPaint(
          size: Size(width,
              height), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: ClientListTopShape(),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Clients",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
        ScrollableClientList(clients: clients)
      ],
    );
  }
}

class ScrollableClientList extends StatelessWidget {
  final List<Client> _clients;

  const ScrollableClientList({
    required clients,
    Key? key,
  })  : _clients = clients,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          itemBuilder: ((context, index) =>
              const ArrowPicCard(title: Text("Luca"))),
          separatorBuilder: ((context, index) => const SizedBox(height: 15)),
          itemCount: 2),
    );
  }
}
