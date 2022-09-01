import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/firebase_client.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/model/client.dart';
import 'package:pdg_app/model/dietitian.dart';

class ClientListProvider extends ChangeNotifier {
  late FirebaseClient firebaseClient;
  List<Client>? _clients;
  List<Client>? _filteredClients;
  bool _loading = false;

  ClientListProvider({required dietitianUid})
      : firebaseClient = FirebaseClient(FirebaseFirestore.instance) {
    fetchAllClients(dietitianUid);
  }

  List<Client>? get clients => _clients;

  List<Client>? get filteredClients => _filteredClients;

  bool get isLoading => _loading;

  void fetchAllClients(String dietitianUid) async {
    _loading = true;
    //TODO décommenter
    // _clients = await firebaseClient.getDietitianClient(dietitianUid);
    await Future.delayed(const Duration(seconds: 1));
    _clients = [
      Client(
        firstName: "Nelson",
        lastName: "Jeanrenaud",
        birthDate: DateTime(2001, 09, 01),
        insurance: "8979279728973912",
        phoneNumber: "0798746756",
      ),
      Client(
        firstName: "Luca",
        lastName: "Coduri",
        birthDate: DateTime(2001, 09, 01),
        insurance: "8979279728973912",
        phoneNumber: "0798746756",
      ),
      Client(
        firstName: "Olivier",
        lastName: "D'Ancona",
        birthDate: DateTime(2001, 09, 01),
        insurance: "8979279728973912",
        phoneNumber: "0798746756",
      )
    ];

    _filteredClients = _clients;
    _loading = false;
    notifyListeners();
  }

  void filterClients(String query) {}
}
