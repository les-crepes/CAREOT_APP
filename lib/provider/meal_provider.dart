import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdg_app/api/firebase_file.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/api/imeal.dart';

import '../api/ifile.dart';
import '../model/meal.dart';

class MealProvider extends ChangeNotifier {
  final IMeal _mealApi = FirebaseMeal(FirebaseFirestore.instance);
  final String _uid;
  bool _isFetching = false;
  final IFile _fileApi = FirebaseFile(FirebaseStorage.instance);
  StreamSubscription<List<Meal>>? _subscription;

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

  Future<void> addMeal(Meal meal, XFile? pic) async {
    String? picUrl = await uploadMealPic(pic, meal.uid);
    meal.photo = picUrl;
    await _mealApi.createMeal(meal);
    notifyListeners();
  }

  Future<void> updateMeal(Meal meal, XFile? pic) async {
    if (pic != null) {
      String? picUrl = await uploadMealPic(pic, meal.uid);
      meal.photo = picUrl;
    }

    await _mealApi.updateMeal(meal);
    notifyListeners();
  }

  // Return the meal pic URL
  Future<String?> uploadMealPic(XFile? pic, String mealUid) async {
    String? picUrl;
    if (pic != null) {
      String path = "images/diary/$mealUid.jpg";
      picUrl = await _fileApi.uploadFile(pic.path, path);
      log(picUrl);
      log(pic.path);
    }

    return picUrl;
  }

  void startNewDiaryListener(String userId) {
    if (_subscription != null) return;

    final subscription = _mealApi.followMeals(userId).listen((event) {
      _meals = event;
      notifyListeners();
    });

    _subscription = subscription;
  }

  /// Stop listening to new incoming meal.
  void stopNewDiaryListener() {
    _subscription?.cancel();
  }
}
