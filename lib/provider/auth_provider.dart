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

  /// Return true if the user is admin (Dietitian).
  bool get isAdmin => _isAdmin;

  /// Return the currently connected user's data.
  User? get user => _client;

  /// Returns the dietitian of the client.
  ///
  /// It's null if it wasn't fetched or if the user is a dietitian.
  User? get clientDietitian => _clientDietitian;

  /// Returns the user's uid.
  String get userUid => _auth.uid;

  /// Returns true if the user is connected.
  bool isConnected() {
    return _auth.isConnected;
  }

  /// Sign in using [email] and [password].
  Future<void> signIn(String email, String password) async {
    await _auth.signIn(email: email, password: password);
    _isAdmin = await _auth.isDietitian();
    if (isConnected()) {
      await fetchClient();
      await fetchClientDietitian();
    }

    notifyListeners();
  }

  /// It signs out the user and deletes cache related to the user.
  Future<void> signOut() async {
    await _auth.signOut();
    _client = null;
    _clientDietitian = null;
    _isAdmin = false;
    notifyListeners();
  }

  /// register a new user using [email] and [password] as credentials.
  Future<void> register(String email, String password, User user) async {
    await _auth.register(email: email, password: password);
    user.uid = _auth.uid;
    await _userApi.createUser(user);
    _client = user;
    notifyListeners();
  }

  /// Return and stores the loged in user from the database.
  ///
  /// The user is stored in [this.user].
  Future<User?> fetchClient() async {
    try {
      _client = await _userApi.readUser(_auth.uid);
      notifyListeners();
    } catch (e) {
      log("Error fetching client: $e");
    }

    return _client;
  }

  /// Returns and stores the dietitian of the user.
  ///
  /// The dietitian is stored in [this.clientDietitian].
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
    return null;
  }
}
