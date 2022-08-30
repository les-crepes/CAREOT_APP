import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_connection.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/iclient.dart';

import '../api/firebase_client.dart';
import '../model/client.dart';

class AuthProvider extends ChangeNotifier {
  final Auth _auth = FirebaseConnection();
  final IClient _clientApi = FirebaseClient(FirebaseFirestore.instance);

  Client? _client;

  bool isConnected() {
    return _auth.isConnected;
  }

  String get userUid => _auth.uid;

  Client? get client => _client;

  Future<void> signIn(String email, String password) async {
    final isConnected = await _auth.signIn(email: email, password: password);

    if (isConnected) {
      _client = await _clientApi.readClient(_auth.uid);
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _client = null;
    notifyListeners();
  }
}
