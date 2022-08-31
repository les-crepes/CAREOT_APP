import 'package:flutter/material.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/iclient.dart';

import '../model/client.dart';

class AuthProvider extends ChangeNotifier {
  final Auth _auth;
  final IClient _clientApi;

  AuthProvider({required Auth auth, required IClient clientApi})
      : _auth = auth,
        _clientApi = clientApi;

  Client? _client;

  bool isConnected() {
    return _auth.isConnected;
  }

  String get userUid => _auth.uid;

  Client? get client => _client;

  Future<void> signIn(String email, String password) async {
    //final isConnected = await _auth.signIn(email: email, password: password);
    final isConnected =
        await _auth.signIn(email: "luca.coduri@heig-vd.ch", password: 'crepes');

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

  Future<void> register(String email, String password) async {
    await _auth.register(email: email, password: password);
  }
}
