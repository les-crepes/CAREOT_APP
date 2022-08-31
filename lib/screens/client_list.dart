import 'package:flutter/material.dart';

import '../widgets/client_list.dart/top_shape.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClientList();
  }
}

class ClientList extends StatelessWidget {
  final double _screenWidth;
  const ClientList({
    screenWidth = 0.0,
    Key? key,
  })  : _screenWidth = screenWidth,
        super(key: key);

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
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clients",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
