import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iauth.dart';
import 'package:pdg_app/api/iuser.dart';

class FirebaseConnection implements Auth {
  FirebaseConnection._();
  static final FirebaseConnection _instance = FirebaseConnection._();

  factory FirebaseConnection() => _instance;

  @override
  bool get isConnected => FirebaseAuth.instance.currentUser != null;

  @override
  String get uid {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Not connected");
    }
    return user.uid;
  }

  @override
  bool get isVerified {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Not connected");
    }
    user.reload();
    return user.emailVerified;
  }

  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      if (isConnected) {
        log("Already connected");
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
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
  Future<bool> register(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> sendVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Not connected");
    }
    user.sendEmailVerification();
  }

  @override
  String getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("Not connected");
    }
    return user.email!;
  }

  @override
  Future<bool> isDietitian() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    IUser dietitianApi = FirebaseUser(FirebaseFirestore.instance);
    if (userId == null) return false;
    try {
      final dietitian = await dietitianApi.readUser(userId);
      return dietitian.clientList != null;
    } catch (e) {
      return false;
    }
  }
}
