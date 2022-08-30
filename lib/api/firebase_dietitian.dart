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
        .add(dietitian.toJson())
        .then((value) => log("Dietitian Added"))
        .catchError((error) {
      log("Failed to add dietitian: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Dietitian> readDietitian(String dietitianId) async {
    final docRef = collectionReference.doc(dietitianId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Dietitian.fromJson(data);
  }

  @override
  void updateDietitian(Dietitian dietitian) {
    collectionReference
        .doc('FAKE')
        .update(dietitian.toJson())
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
