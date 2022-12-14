import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/ifile.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/user.dart';

/// This class is used to manage the Authentification.
class AuthProvider extends ChangeNotifier {
  final Auth _auth;
  final IUser _userApi;
  final IFile _fileApi;
  bool _isAdmin = false;

  User? _client;
  User? _clientDietitian;

  AuthProvider(
      {required Auth auth, required IUser clientApi, required IFile fileApi})
      : _auth = auth,
        _userApi = clientApi,
        _fileApi = fileApi;

  /// Fetched the initial values from database.
  ///
  /// It needs to be run at startup.
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

// Return the profile pic URL
  Future<String?> uploadProfilePic(XFile? pic, String userUid) async {
    String? picUrl;
    if (pic != null) {
      String path = "images/profile/$userUid.jpg";
      picUrl = await _fileApi.uploadFile(pic.path, path);
      log(picUrl);
      log(pic.path);
    }

    return picUrl;
  }

  /// register a new user using [email] and [password] as credentials.
  Future<void> register(
      String email, String password, User user, XFile? pic) async {
    String? picUrl = await uploadProfilePic(pic, user.uid);

    await _auth.register(email: email, password: password);

    user.uid = _auth.uid;
    user.photoUrl = picUrl;

    await _userApi.createUser(user);
    _client = user;

    await _userApi.addClient(user.uid, dotenv.env['DIET_UID'] as String);
    await fetchClientDietitian();

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
