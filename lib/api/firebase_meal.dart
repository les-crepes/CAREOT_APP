import 'dart:developer';

import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMeal implements IMeal {
  CollectionReference meals = FirebaseFirestore.instance.collection('meal');

  @override
  void createMeal(Meal meal) {
    meals
        .add(meal.toJson())
        .then((value) => log("Meal Added"))
        .catchError((error) {
      log("Failed to add meal: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteMeal(String mealId) {
    meals.doc(mealId).delete();
  }

  @override
  Future<Meal> readMeal(String mealId) async {
    final docRef = meals.doc(mealId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Meal.fromJson(data);
  }

  @override
  updateMeal(Meal meal) {
    meals
        .doc('FAKE')
        .update(meal.toJson())
        .then((value) => log("Meal Updated"))
        .catchError((error) {
      log("Failed to update meal: $error");
      throw Exception(error);
    });
  }
}
