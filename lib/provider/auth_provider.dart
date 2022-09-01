import 'package:flutter/material.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/iuser.dart';

import '../model/user.dart';

class AuthProvider extends ChangeNotifier {
  final Auth _auth;
  final IUser _userApi;

  AuthProvider({required Auth auth, required IUser clientApi})
      : _auth = auth,
        _userApi = clientApi;

  User? _client;

  bool isConnected() {
    return _auth.isConnected;
  }

  String get userUid => _auth.uid;

  User? get user => _client;

  Future<void> signIn(String email, String password) async {
    //final isConnected = await _auth.signIn(email: email, password: password);
    final isConnected =
        await _auth.signIn(email: "luca.coduri@heig-vd.ch", password: 'crepes');

    if (isConnected) {
      _client = await _userApi.readUser(_auth.uid);
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
