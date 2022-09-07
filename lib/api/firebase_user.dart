import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/model/user.dart';
import 'exceptions.dart';

/// Implementation of the [Iuser] API interface for Firebase.
class FirebaseUser extends FirebaseAPI implements IUser {
  FirebaseUser(FirebaseFirestore db) : super(db, 'user');

  @override
  Future<void> createUser(User user) async {
    try {
      await collectionReference
          .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, options) => user.toFirestore())
          .doc(user.uid)
          .set(user);
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getDatabaseExceptionFromCode(e.code);
    }
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
    }
    throw DatabaseException(DatabaseExceptionType.notFound);
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      collectionReference
          .doc(user.uid)
          .update(user.toFirestore());
      log('User updated');
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  void deleteUser(String clientId) {
    try {
      collectionReference.doc(clientId).delete();
      log('User deleted');
    } on FirebaseException catch (e) {
      throw getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  Future<List<User>> getDietitianClient(String dietitianId) async {
    try {
      final docRef = collectionReference.doc(dietitianId).withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User dietitian, _) => dietitian.toFirestore(),
      );
      final docSnapshot = await docRef.get();
      final d = docSnapshot.data();
      final m =
      await collectionReference.where("uid", whereIn: d?.clientList).get();
      List<User> clients = m.docs
          .map((doc) =>
          User(
              birthDate: doc['birthDate'].toDate(),
              firstName: doc['firstName'],
              avs: doc['avs'],
              lastName: doc['lastName'],
              phoneNumber: doc['phoneNumber'],
              email: doc['email'],
              photoUrl: doc['photoUrl'],
              uid: doc['uid']))
          .toList();
      return clients;
    } on FirebaseException catch (e) {
      throw getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  Future<User?> readDietitianOfClient(String clientId) async {
    try {
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
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  Future<void> addClient(String userId, String dietitianId) async {
    final dietitian = await readUser(dietitianId);
    dietitian.addUser(userId);
    await updateUser(dietitian);
  }

  @override
  Stream<List<User>> followDietitianClientList(String dietitianId) {
    Future<List<User>> lookForUser(List<dynamic> userIds) async {
      final futures = userIds.map((e) => readUser(e as String));

      return Future.wait(futures);
    }

    Stream<DocumentSnapshot<User>> docSnapshot = collectionReference
        .doc(dietitianId)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User dietitian, _) => dietitian.toFirestore(),
        )
        .snapshots(includeMetadataChanges: true);
    // final docSnapshot = docRef.snapshots();
    final clientList = docSnapshot
        .map((doc) => doc.data())
        .map((user) => user!.clientList!)
        .asyncMap(lookForUser);

    return clientList;
  }
}
