import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/model/user.dart';

class FirebaseUser extends FirebaseAPI implements IUser {
  FirebaseUser(FirebaseFirestore db) : super(db, 'user');

  @override
  Future<void> createUser(User user) async {
    await collectionReference
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore())
        .doc(user.uid)
        .set(user);
  }

  @override
  Future<User> readUser(String userId) async {
    final docRef = collectionReference.doc(userId).withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, _) => user.toFirestore(),
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
  Future<void> updateUser(User user) async {
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
    final docRef = collectionReference.doc(dietitianId).withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User dietitian, _) => dietitian.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final d = docSnapshot.data();
    final m =
        await collectionReference.where("uid", whereIn: d?.clientList).get();
    List<User> clients = m.docs
        .map((doc) => User(
            birthDate: doc['birthDate'].toDate(),
            firstName: doc['firstName'],
            avs: doc['avs'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
            email: doc['email'],
            uid: doc['uid']))
        .toList();
    return clients;
  }

  @override
  Future<User?> readDietitianOfClient(String clientId) async {
    final querySnapshot = await collectionReference
        .where('clientList', arrayContains: clientId)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User dietitian, _) => dietitian.toFirestore(),
        )
        .get();
    List<User> dietitians =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return dietitians.isNotEmpty ? dietitians.first : null;
  }

  @override
  Future<void> addClient(String userId, String dietitianId) async {
    final dietitian = await readUser(dietitianId);
    dietitian.addUser(userId);
    await updateUser(dietitian);
  }
}
