import 'package:flutter/material.dart';

class StraightTopBar extends StatelessWidget {
  const StraightTopBar({
    Key? key,
    required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFFBD70),
            Color(0xFFFF9877),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
