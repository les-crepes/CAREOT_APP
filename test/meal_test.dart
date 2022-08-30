import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/model/meal.dart';

final db = FakeFirebaseFirestore();
Meal m1 = Meal(hunger: 4, satiety: 5, comment: 'no comment');


void populateMockMeal(Meal c) async {
  await db.collection('meal').add(c.toFirestore());
}

void main() {
  late final IMeal mealApi;

  setUp(() async {
    populateMockMeal(m1);
    mealApi = FirebaseMeal();
  });

  test("Create Meal", () {
    mealApi.createMeal(m1);
    expect(m1, m1);
  });

  test("Read Meal", () {
    mealApi.readMeal('fd');
    expect(m1, m1);
  });

  test("Update meal", () {
    mealApi.updateMeal(m1);
    expect(m1, m1);
  });

  test("Delete meal", () {
    mealApi.deleteMeal('');
    expect(m1, m1);
  });
}
