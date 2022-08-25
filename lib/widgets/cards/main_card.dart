import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Widget child;

  const MainCard({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 25,
            offset: Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Card(
        child: child,
      ),
    );
  }
}
