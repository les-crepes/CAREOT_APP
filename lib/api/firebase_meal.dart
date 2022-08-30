import 'dart:developer';

import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

class FirebaseMeal extends FirebaseAPI implements IMeal {
  FirebaseMeal(FirebaseFirestore db) : super(db, 'meal');

  @override
  void createMeal(Meal meal) {
    collectionReference
        .withConverter(
            fromFirestore: Meal.fromFirestore,
            toFirestore: (Meal meal, options) => meal.toFirestore())
        .doc(meal.uid)
        .set(meal)
        .then((value) => log("Meal Added"))
        .catchError((error) {
      log("Failed to add meal: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Meal> readMeal(String mealId) async {
    final docRef = collectionReference.doc(mealId).withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal city, _) => city.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final meal = docSnapshot.data();
    if (meal != null) {
      return meal;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  void updateMeal(Meal meal) {
    collectionReference
        .doc(meal.uid)
        .update(meal.toFirestore())
        .then((value) => log("Meal Updated"))
        .catchError((error) {
      log("Failed to update meal: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteMeal(String mealId) {
    collectionReference.doc(mealId).delete();
  }
}
