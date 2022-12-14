import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/imeal.dart';
import 'package:pdg_app/api/firebase_meal.dart';
import 'package:pdg_app/model/user.dart';
import 'package:pdg_app/model/meal.dart';

final db = FakeFirebaseFirestore();
DateTime fisherDay = DateTime(2017, 9, 7, 17, 30);
Meal m2 = Meal(
    startTime: fisherDay,
    endTime: fisherDay,
    owner: c1.uid,
    hunger: 4,
    satiety: 5,
    comment: 'no comment',
    title: 'mojo');
Meal m1 = Meal(
    startTime: fisherDay,
    endTime: fisherDay,
    owner: c1.uid,
    hunger: 4,
    satiety: 2,
    comment: 'wow',
    title: 'jojo');
User c1 = User(
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0780001223',
    birthDate: fisherDay,
    avs: '',
    email: 'olivier.dancona@gmail.com');

Future<void> populateMockMeal(Meal c) async {
  await db.collection('meal').doc(c.uid).set(c.toFirestore());
}

Future<void> populateMockClient(User c) async {
  await db.collection('client').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IMeal mealApi;
  final meals = db.collection('meal');

  setUp(() async {
    populateMockMeal(m1);
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
          toFirestore: (Meal meal, _) => meal.toFirestore(),
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
          toFirestore: (Meal meal, _) => meal.toFirestore(),
        )
        .get();
    final meal = docSnapshot.data();
    expect(meal, null);
  });

  test("getUsersMealForDay", () async {
    List<Meal> coco = [m1, m2];
    final meals = await mealApi.getUsersMealForDay(c1.uid, fisherDay);
    expect(meals.elementAt(0).toString(), coco.elementAt(0).toString());
  });
}
