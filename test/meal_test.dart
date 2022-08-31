import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/model/client.dart';
import 'package:pdg_app/model/meal.dart';

final db = FakeFirebaseFirestore();
DateTime fisherDay = DateTime(2017,9,7,17,30);
Meal m1 = Meal(startTime: fisherDay, owner:c1, hunger: 4, satiety: 5, comment: 'no comment');
Meal m2 = Meal(startTime: fisherDay, owner:c1,hunger: 32, satiety: 2, comment: 'wow');
Client c1 = Client(
    firstName: 'Olivier', lastName: 'D\'Ancona', phoneNumber: '0780001223');

Future<void> populateMockMeal(Meal c) async {
  await db.collection('meal').doc(c.uid).set(c.toFirestore());
}

Future<void> populateMockClient(Client c) async {
  await db.collection('client').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IMeal mealApi;
  final meals = db.collection('meal');

  setUp(() async {
    populateMockMeal(m2);
    populateMockClient(c1);
    mealApi = FirebaseMeal(db);
  });

  test("Create Meal", () async {
    mealApi.createMeal(m1);
    final docSnapshot = await meals
        .doc(m1.uid)
        .withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal meal, _) => meal.toFirestore(),
        )
        .get();
    final meal = docSnapshot.data();
    expect(m1.toString(), meal.toString());
  });

  test("Read Meal", () async {
    final Meal m2Bis = await mealApi.readMeal(m2.uid);
    expect(m2.toString(), m2Bis.toString());
  });

  test("Update meal", () async {
    m1.setComment('Filippo');
    mealApi.updateMeal(m1);
    final docSnapshot = await meals
        .doc(m1.uid)
        .withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.comment);
  });

  test("Delete meal", () async {
    mealApi.deleteMeal(m2.uid);
    final docSnapshot = await meals
        .doc(m2.uid)
        .withConverter(
          fromFirestore: Meal.fromFirestore,
          toFirestore: (Meal city, _) => city.toFirestore(),
        )
        .get();
    final meal = docSnapshot.data();
    expect(meal, null);
  });

  test("getUsersMealForDay", () async {
    mealApi.getUsersMealForDay(c1.uid, )
  });
}
