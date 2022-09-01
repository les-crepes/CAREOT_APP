import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/model/dietitian.dart';
import 'package:pdg_app/model/user.dart';

class FirebaseUser extends FirebaseAPI implements IUser {
  FirebaseUser(FirebaseFirestore db) : super(db, 'user');

  @override
  void createUser(User user) {
    collectionReference
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore())
        .doc(user.uid)
        .set(user)
        .then((value) => log("User Added"))
        .catchError((error) {
      log("Failed to add user: $error");
      throw Exception(error);
    });
  }

  @override
  Future<User> readUser(String clientId) async {
    final docRef = collectionReference.doc(clientId).withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User city, _) => city.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final user = docSnapshot.data();
    if (user != null) {
      return user;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  void updateUser(User user) {
    collectionReference
        .doc(user.uid)
        .update(user.toFirestore())
        .then((value) => log("User Updated"))
        .catchError((error) {
      log("Failed to update user: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteUser(String clientId) {
    collectionReference.doc(clientId).delete();
  }

  @override
  Future<List<User>> getDietitianClient(String dietitianId) async {
    IDietitian dietitianApi = FirebaseDietitian(super.getDb());
    Dietitian d = await dietitianApi.readDietitian(dietitianId);
    final m =
        await collectionReference.where("uid", whereIn: d.clientList).get();
    List<User> clients = m.docs
        .map((doc) => User(
            birthDate: doc['birthDate'].toDate(),
            firstName: doc['firstName'],
            avs: doc['avs'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
            uid: doc['uid']))
        .toList();
    return clients;
  }
}
