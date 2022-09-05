import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp());

  IUser userApi = FirebaseUser(FirebaseFirestore.instance);

  await userApi.addClient("coco", "PSCOEhz98TORfOb9BizGfjUA8hc2");
  final coco = await userApi.readUser("PSCOEhz98TORfOb9BizGfjUA8hc2");
  log(coco.clientList.toString());
  log("programme terminé");
}
