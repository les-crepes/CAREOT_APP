import 'package:pdg_app/model/meal.dart';

/// Interface for the meal API
abstract class IMeal {
  /// Add [meal] to the database
  Future<void> createMeal(Meal meal);

  /// Returns the meal in the database with [mealId]
  Future<Meal> readMeal(String mealId);

  /// Update the [meal] in the database
  Future<void> updateMeal(Meal meal);

  /// Delete the meal with [mealId] from the database
  void deleteMeal(String mealId);

  /// Get the meals of the user [userId] for the day [day]
  Future<List<Meal>> getUsersMealForDay(String userId, DateTime day);

  /// Subscribe to the user [userId] meals for the day [day]
  Stream<Meal?> followMeals(String userId, DateTime day);

  /// Get the meals of the user [userId]
  Future<List<Meal>> getUserMeal(String userId);
}
