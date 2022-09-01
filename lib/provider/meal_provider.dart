import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/imeal.dart';

import '../model/meal.dart';

class MealProvider extends ChangeNotifier {
  final IMeal _mealApi = FirebaseMeal(FirebaseFirestore.instance);
  final String _uid;
  bool _isFetching = false;

  MealProvider(this._uid) {
    fetchMeals();
  }

  List<Meal> _meals = [];

  List<Meal> get meals => _meals;

  bool get isFetching => _isFetching;

  Future<List<Meal>> fetchMeals() async {
    _isFetching = true;
    IMeal mealApi = FirebaseMeal(FirebaseFirestore.instance);
    _meals = await mealApi.getUserMeal(_uid);
    _isFetching = false;
    notifyListeners();
    return _meals;
  }

  List<Meal> getMealsByDay(DateTime date) {
    return meals.where((element) {
      return element.startTime.day == date.day &&
          element.startTime.month == date.month &&
          element.startTime.year == date.year;
    }).toList();
  }

  Future<void> addMeal(Meal meal) async {
    _meals.add(meal);
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  static List<Meal> _filterMealsByDay(Map<int, dynamic> args) {
    final meals = args[1];
    final date = args[2];
    return meals.where((element) {
      return element.startTime.day == date.day;
    }).toList();
  }
}
