import 'dart:developer';

import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/model/dietitian.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

class FirebaseDietitian extends FirebaseAPI implements IDietitian {
  FirebaseDietitian(FirebaseFirestore db) : super(db, 'dietitian');

  @override
  void createDietitian(Dietitian dietitian) {
    collectionReference
        .withConverter(
            fromFirestore: Dietitian.fromFirestore,
            toFirestore: (Dietitian dietitian, options) =>
                dietitian.toFirestore())
        .doc(dietitian.uid)
        .set(dietitian)
        .then((value) => log("Dietitian Added"))
        .catchError((error) {
      log("Failed to add dietitian: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Dietitian> readDietitian(String dietitianId) async {
    final docRef = collectionReference.doc(dietitianId).withConverter(
          fromFirestore: Dietitian.fromFirestore,
          toFirestore: (Dietitian dietitian, _) => dietitian.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final dietitian = docSnapshot.data();
    if (dietitian != null) {
      return dietitian;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  Future<Dietitian> readDietitianOfClient(String clientId) async {
    final querySnapshot = await collectionReference
        .where('clientList', arrayContains: clientId)
        .withConverter(
          fromFirestore: Dietitian.fromFirestore,
          toFirestore: (Dietitian dietitian, _) => dietitian.toFirestore(),
        )
        .get();
    List<Dietitian> dietitians =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    return dietitians.first;
  }

  @override
  void updateDietitian(Dietitian dietitian) {
    collectionReference
        .doc(dietitian.uid)
        .update(dietitian.toFirestore())
        .then((value) => log("Dietitian Updated"))
        .catchError((error) {
      log("Failed to update dietitian: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteDietitian(String dietitianId) {
    collectionReference.doc(dietitianId).delete();
  }
}
