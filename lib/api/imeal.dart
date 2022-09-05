import 'package:pdg_app/model/meal.dart';

abstract class IMeal {
  Future<void> createMeal(Meal meal);
  Future<Meal> readMeal(String mealId);
  Future<void> updateMeal(Meal meal);
  void deleteMeal(String mealId);
  Future<List<Meal>> getUsersMealForDay(String userId, DateTime day);
  Future<List<Meal>> getUserMeal(String userId);
}
