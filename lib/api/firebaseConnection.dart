import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdg_app/api/connection.dart';

class FirebaseConnection implements Connection {
  @override
  Future<bool> connect(
      {required String email, required String password}) async {
    try {
      if(isConnected) {
        print("Already connected");
      }
      else {
        UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  @override
  bool get isConnected => FirebaseAuth.instance.currentUser != null;

  @override
  Future<bool> register({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}