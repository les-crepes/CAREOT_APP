import 'dart:developer';

import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/model/aftercare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAftercare implements IAftercare {
  FirebaseAftercare._();
  static final FirebaseAftercare _instance = FirebaseAftercare._();
  factory FirebaseAftercare() => _instance;

  CollectionReference aftercares =
      FirebaseFirestore.instance.collection('aftercare');

  @override
  void createAftercare(Aftercare aftercare) {
    aftercares
        .add(aftercare.toFirestore())
        .then((value) => log("Aftercare Added"))
        .catchError((error) {
      log("Failed to add aftercare: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteAftercare(String aftercareId) {
    aftercares.doc(aftercareId).delete();
  }

  @override
  Future<Aftercare> readAftercare(String aftercareId) async {
    final docRef = aftercares.doc(aftercareId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Aftercare.fromJson(data);
  }

  @override
  updateAftercare(Aftercare aftercare) {
    aftercares
        .doc('FAKE')
        .update(aftercare.toFirestore())
        .then((value) => log("Aftercare Updated"))
        .catchError((error) {
      log("Failed to update aftercare: $error");
      throw Exception(error);
    });
  }
}
