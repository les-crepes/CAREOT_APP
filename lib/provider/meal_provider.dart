import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/imeal.dart';

import '../model/meal.dart';

class MealProvider extends ChangeNotifier {
  final IMeal _mealApi = FirebaseMeal(FirebaseFirestore.instance);

  MealProvider() {
    fetchMeals();
  }

  final List<Meal> _meals = [
    Meal(
      endTime: DateTime.now(),
      startTime: DateTime.now(),
      title: 'test',
      hunger: 0,
      satiety: 0,
      owner: "1",
      comment: "Comment",
    ),
    Meal(
      endTime: DateTime.now(),
      startTime: DateTime.now(),
      title: 'test2',
      hunger: 0,
      satiety: 0,
      owner: "2",
      comment: "Comment",
    ),
    Meal(
      endTime: DateTime.now(),
      startTime: DateTime.now(),
      title: 'test3',
      hunger: 0,
      satiety: 0,
      owner: "3",
      comment: "Comment",
    ),
    Meal(
      endTime: DateTime.now().add(const Duration(days: 1)),
      startTime: DateTime.now().add(const Duration(days: 1)),
      title: 'test3',
      hunger: 0,
      satiety: 0,
      owner: "3",
      comment: "Comment",
    ),
  ];

  List<Meal> get meals => _meals;

  Future<List<Meal>> fetchMeals() async {
    await Future.delayed(const Duration(seconds: 1));
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
