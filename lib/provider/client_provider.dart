import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/model/user.dart';

class ClientProvider extends ChangeNotifier {
  late FirebaseUser firebaseClient;
  List<User>? _clients;
  List<User>? _filteredClients;
  bool _loading = false;
  StreamSubscription<List<User>>? _subscription;

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

  void startNewClientListener() {
    String dietId = dotenv.env['DIET_UID'] as String;

    if (_subscription != null) return;

    _subscription =
        firebaseClient.followDietitianClientList(dietId).listen((event) {
      log(event.toString());
      _clients = event;
      _filteredClients = event;
      notifyListeners();
      log("notify");
    });
  }

  void stopNewClientListener() {
    _subscription?.cancel();
  }
}
