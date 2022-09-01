import 'package:flutter/material.dart';

import '../model/user.dart';

class ClientRecordScreen extends StatelessWidget {
  final User _user;

  const ClientRecordScreen({required User user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("dossier " + _user.firstName));
  }
}
