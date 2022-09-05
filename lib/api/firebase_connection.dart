import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdg_app/api/exceptions.dart';
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

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// A [AuthenticationException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///  - Thrown if the email address is not valid.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the given email.
  /// - **wrong-password**:
  ///  - Thrown if the password is invalid for the given email, or the account
  ///    corresponding to the email does not have a password set.
  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      if (isConnected) {
        log("Already connected");
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw AuthenticationException(LoginExceptionType.userNotFound);
        case "wrong-password":
          throw AuthenticationException(LoginExceptionType.wrongPassword);
        case "invalid-email":
          throw AuthenticationException(LoginExceptionType.invalidEmail);
        case "user-disabled":
          throw AuthenticationException(LoginExceptionType.userDisabled);
        default:
          throw AuthenticationException(LoginExceptionType.unknown);
      }
    }
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

  @override
  // Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }
}
