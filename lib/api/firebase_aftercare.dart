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
        .withConverter(
            fromFirestore: Aftercare.fromFirestore,
            toFirestore: (Aftercare aftercare, options) =>
                aftercare.toFirestore())
        .doc(aftercare.uid)
        .set(aftercare)
        .then((value) => log("Aftercare Added"))
        .catchError((error) {
      log("Failed to add aftercare: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Aftercare> readAftercare(String aftercareId) async {
    final docRef = collectionReference.doc(aftercareId).withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final aftercare = docSnapshot.data();
    if (aftercare != null) {
      return aftercare;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  updateAftercare(Aftercare aftercare) {
    collectionReference
        .doc(aftercare.uid)
        .update(aftercare.toFirestore())
        .then((value) => log("Aftercare Updated"))
        .catchError((error) {
      log("Failed to update aftercare: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteAftercare(String aftercareId) {
    collectionReference.doc(aftercareId).delete();
  }
}
