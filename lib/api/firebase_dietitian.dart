import 'dart:developer';

import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/model/dietitian.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDietitian implements IDietitian {
  FirebaseDietitian._();
  static final FirebaseDietitian _instance = FirebaseDietitian._();
  factory FirebaseDietitian() => _instance;

  CollectionReference dietitians =
      FirebaseFirestore.instance.collection('dietician');

  @override
  void createDietitian(Dietitian dietitian) {
    dietitians
        .add(dietitian.toFirestore())
        .then((value) => log("Dietitian Added"))
        .catchError((error) {
      log("Failed to add dietitian: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Dietitian> readDietitian(String dietitianId) async {
    final docRef = dietitians.doc(dietitianId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Dietitian.fromJson(data);
  }

  @override
  void updateDietitian(Dietitian dietitian) {
    dietitians
        .doc('FAKE')
        .update(dietitian.toFirestore())
        .then((value) => log("Dietitian Updated"))
        .catchError((error) {
      log("Failed to update dietitian: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteDietitian(String dietitianId) {
    dietitians.doc(dietitianId).delete();
  }
}
