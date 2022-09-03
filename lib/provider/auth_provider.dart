import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/iuser.dart';

import '../model/user.dart';

class AuthProvider extends ChangeNotifier {
  final Auth _auth;
  final IUser _userApi;
  bool _isAdmin = false;

  User? _client;
  User? _clientDietitian;

  AuthProvider({required Auth auth, required IUser clientApi})
      : _auth = auth,
        _userApi = clientApi;

  Future<void> init() async {
    if (isConnected()) {
      final values = await Future.wait([
        fetchClient(),
        _auth.isDietitian(),
      ]);

      _isAdmin = values[1] as bool;
      await fetchClientDietitian();
    }
  }

  bool get isAdmin => _isAdmin;

  User? get user => _client;

  User? get clientDietitian => _clientDietitian;

  String get userUid => _auth.uid;

  bool isConnected() {
    return _auth.isConnected;
  }

  Future<void> signIn(String email, String password) async {
    final isConnected = await _auth.signIn(email: email, password: password);
    //final isConnected =
    //await _auth.signIn(email: "luca.coduri@heig-vd.ch", password: 'crepes');
    _isAdmin = await _auth.isDietitian();
    if (isConnected) {
      await fetchClient();
      await fetchClientDietitian();
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _client = null;
    _clientDietitian = null;
    _isAdmin = false;
    notifyListeners();
  }

  Future<void> register(String email, String password, User user) async {
    await _auth.register(email: email, password: password);
    user.uid = _auth.uid;
    await _userApi.createUser(user);
    _client = user;
    notifyListeners();
  }

  Future<User?> fetchClient() async {
    try {
      _client = await _userApi.readUser(_auth.uid);
      notifyListeners();
    } catch (e) {
      log("Error fetching client: $e");
    }

    return _client;
  }

  Future<User?> fetchClientDietitian() async {
    try {
      if (!isAdmin) {
        _clientDietitian = await _userApi.readDietitianOfClient(_client!.uid);
        notifyListeners();
        return _clientDietitian;
      }
      return null;
    } catch (e) {
      log("Error fetching client's dietitian: $e");
    }
  }
}
