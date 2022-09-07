import 'dart:developer';

import 'package:pdg_app/api/exceptions.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/model/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

/// Implementation of the [IUser] API interface for Firebase.
class FirebaseMeal extends FirebaseAPI implements IMeal {
  FirebaseMeal(FirebaseFirestore db) : super(db, 'meal');

  @override
  Future<void> createMeal(Meal meal) async {
    try {
      await collectionReference
          .withConverter(
              fromFirestore: Meal.fromFirestore,
              toFirestore: (Meal meal, options) => meal.toFirestore())
          .doc(meal.uid)
          .set(meal);
      log("Meal Added");
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }

  @override
  Future<Meal> readMeal(String mealId) async {
    final docRef = collectionReference.doc(mealId).withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal meal, _) => meal.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final meal = docSnapshot.data();
    if (meal != null) {
      return meal;
    } else {
      throw StorageException(StorageExceptionType.notFound);
    }
  }

  @override
  Future<void> updateMeal(Meal meal) async {
    try {
      await collectionReference.doc(meal.uid).update(meal.toFirestore());
      log("Meal Updated");
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }

  @override
  void deleteMeal(String mealId) {
    try {
      collectionReference.doc(mealId).delete();
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }

  @override
  Future<List<Meal>> getUsersMealForDay(String userId, DateTime day) async {
    DateTime newD = DateTime(day.year, day.month, day.day, 0, 0); /// Start of the day
    DateTime endD = newD.add(const Duration(days: 1)); /// End of the day
    try {
      final m = await collectionReference
          .where("owner", isEqualTo: userId)
          .where("startTime", isGreaterThanOrEqualTo: newD)
          .where("startTime", isLessThanOrEqualTo: endD)
          .withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal meal, options) => meal.toFirestore())
          .get();
          List<Meal> meals = m.docs.map((doc) => doc.data()).toList();
          return meals;
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }

  @override
  Future<List<Meal>> getUserMeal(String userId) async {
    try {
      final m = await collectionReference
          .where("owner", isEqualTo: userId)
          .withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal meal, options) => meal.toFirestore())
          .get();
      List<Meal> meals = m.docs.map((doc) => doc.data()).toList();
      return meals;
    } on FirebaseException catch (e) {
      throw super.getStorageExceptionFromCode(e.code);
    }
  }
}
