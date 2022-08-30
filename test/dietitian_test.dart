import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/model/dietitian.dart';

final db = FakeFirebaseFirestore();
  Dietitian d1 = Dietitian(firstName: 'Claire', lastName: 'Emery');
  Dietitian d2 = Dietitian(firstName: 'Alice', lastName: 'Emery');



Future<void> populateMockDietitian(Dietitian d) async {
  await db.collection('dietitian').doc(d.uid).set(d.toFirestore());
}

void main() {
  late IDietitian dietitianApi;
  final dietitians = db.collection('dietitian');

  setUp(() async {
    populateMockDietitian(d2);
    dietitianApi = FirebaseDietitian(db);
  });

  test("Create Dietitian", () async {
    dietitianApi.createDietitian(d1);
    final docSnapshot = await dietitians
        .doc(d1.uid)
        .withConverter(
          fromFirestore: Dietitian.fromFirestore,
          toFirestore: (Dietitian dietitian, _) => dietitian.toFirestore(),
        )
        .get();
    final dietitian = docSnapshot.data();
    expect(d1.toString(), dietitian.toString());
  });

  test("Read Dietitian", () async {
    final Dietitian c2Bis = await dietitianApi.readDietitian(d2.uid);
    expect(d2.toString(), c2Bis.toString());
  });

  test("Update dietitian", () async {
    d1.setFirstName('Filippo');
    dietitianApi.updateDietitian(d1);
    final docSnapshot = await dietitians
        .doc(d1.uid)
        .withConverter(
          fromFirestore: Dietitian.fromFirestore,
          toFirestore: (Dietitian city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.firstName);
  });

  test("Delete dietitian", () async {
    dietitianApi.deleteDietitian(d2.uid);
    final docSnapshot = await dietitians
        .doc(d2.uid)
        .withConverter(
          fromFirestore: Dietitian.fromFirestore,
          toFirestore: (Dietitian city, _) => city.toFirestore(),
        )
        .get();
    final dietitian = docSnapshot.data();
    expect(dietitian, null);
  });
}