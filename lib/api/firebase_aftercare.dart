import 'dart:developer';

import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

class FirebaseAftercare extends FirebaseAPI implements IAftercare {

  FirebaseAftercare(FirebaseFirestore db) : super(db, 'aftercare');
  
  @override
  void createAftercare(Aftercare aftercare) {
    collectionReference
        .add(aftercare.toJson())
        .then((value) => log("Aftercare Added"))
        .catchError((error) {
      log("Failed to add aftercare: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteAftercare(String aftercareId) {
    collectionReference.doc(aftercareId).delete();
  }

  @override
  Future<Aftercare> readAftercare(String aftercareId) async {
    final docRef = collectionReference.doc(aftercareId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Aftercare.fromJson(data);
  }

  @override
  updateAftercare(Aftercare aftercare) {
    collectionReference
        .doc('FAKE')
        .update(aftercare.toFirestore())
        .then((value) => log("Aftercare Updated"))
        .catchError((error) {
      log("Failed to update aftercare: $error");
      throw Exception(error);
    });
  }
}
