import 'package:flutter/material.dart';
import 'package:pdg_app/model/user.dart';

class UpdateClientRecordScreen extends StatelessWidget {
  final User _user;

  const UpdateClientRecordScreen({required user, Key? key})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Modify " + _user.firstName);
  }
}
