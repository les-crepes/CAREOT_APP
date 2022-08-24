import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdg_app/api/connection.dart';

class FirebaseConnection implements Connection {
  FirebaseConnection._();
  static final FirebaseConnection _instance = FirebaseConnection._();

  factory FirebaseConnection() => _instance;

  @override
  bool get isConnected => FirebaseAuth.instance.currentUser != null;


  @override
  bool get isVerified {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified;
    }
    throw Exception("Not connected");
  }

  @override
  Future<bool> connect(
      {required String email, required String password}) async {
    try {
      if(isConnected) {
        log("Already connected");
      }
      else {
        await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return false;
  }


  @override
  Future<bool> register({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<void> disconnect() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> verify() {
    // TODO: implement verify
    throw UnimplementedError();
  }
}