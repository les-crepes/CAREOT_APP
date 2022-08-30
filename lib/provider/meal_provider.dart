import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/imeal.dart';

import '../model/meal.dart';

class MealProvider extends ChangeNotifier {
  final IMeal _mealApi = FirebaseMeal(FirebaseFirestore.instance);

  List<Meal> meals = [];

  Future<List<Meal>> getMeals() async {
    return [];
  }

  Future<void> addMeal(Meal meal) async {
    await _mealApi.createMeal(meal);
    meals.add(meal);
    notifyListeners();
  }
}
