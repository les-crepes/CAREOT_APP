import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_connection.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp());

  Auth api = FirebaseConnection();
  if (await api.checkIfEmailInUse('olivier.dancona@gmail.com')) {
    log("E-mail déjà utilisé");
  } else {
    log("tranquille");
  }

  log("programme terminé");
}
