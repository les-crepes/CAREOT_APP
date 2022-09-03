import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/model/user.dart';

class ClientProvider extends ChangeNotifier {
  late FirebaseUser firebaseClient;
  List<User>? _clients;
  List<User>? _filteredClients;
  bool _loading = false;

  ClientProvider({required dietitianUid})
      : firebaseClient = FirebaseUser(FirebaseFirestore.instance) {
    fetchAllClients(dietitianUid);
  }

  List<User>? get clients => _clients;

  List<User>? get filteredClients => _filteredClients;

  bool get isLoading => _loading;

  void fetchAllClients(String dietitianUid) async {
    _loading = true;
    _clients = await firebaseClient.getDietitianClient(dietitianUid);

    _filteredClients = _clients;
    _loading = false;
    notifyListeners();
  }

  void filterClients(String query) {
    if (_clients == null || _filteredClients == null) return;

    _filteredClients = [];
    for (User client in _clients!) {
      if ("${client.firstName} ${client.lastName}"
          .trim()
          .toLowerCase()
          .contains(query.toLowerCase().trim())) {
        _filteredClients!.add(client);
      }
    }
  }
}
