import 'package:pdg_app/api/exceptions.dart';
import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

/// Implementation of the [Aftercare] API interface for Firebase.
class FirebaseAftercare extends FirebaseAPI implements IAftercare {
  FirebaseAftercare(FirebaseFirestore db) : super(db, 'aftercare');

  @override
  void createAftercare(Aftercare aftercare) async {
    try {
      await collectionReference
          .withConverter(
              fromFirestore: Aftercare.fromFirestore,
              toFirestore: (Aftercare aftercare, options) =>
                  aftercare.toFirestore())
          .doc(aftercare.uid)
          .set(aftercare);
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
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
      throw DatabaseException(DatabaseExceptionType.notFound);
    }
  }

  @override
  Future<List<Aftercare>> readAftercareOfClient(String clientId) async {
    final querySnapshot = await collectionReference
        .where('clientId', isEqualTo: clientId)
        .withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        )
        .get();
    List<Aftercare> dietitians =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    return dietitians;
  }

  @override
  Future<void> updateAftercare(Aftercare aftercare) async {
    try {
      await collectionReference
          .doc(aftercare.uid)
          .update(aftercare.toFirestore());
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }

  @override
  void deleteAftercare(String aftercareId) {
    try {
      collectionReference.doc(aftercareId).delete();
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }
}
