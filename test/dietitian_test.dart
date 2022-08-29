import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/dietitian.dart';

final db = FakeFirebaseFirestore();
  Dietitian d1 = Dietitian(firstName: 'Claire', lastName: 'Emery', uid: '1');


void populateMockDietitian(Dietitian c) async {
  await db.collection('dietitian').add(c.toJson());
}

void main() {
  late final IDietitian dietitianApi;

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    populateMockDietitian(d1);
    dietitianApi = FirebaseDietitian();
  });

  test("Create Dietitian", () {
    dietitianApi.createDietitian(d1);
    expect(d1, d1);
  });

  test("Read Dietitian", () {
    dietitianApi.readDietitian(d1.uid!);
    expect(d1, d1);
  });

  test("Update dietitian", () {
    dietitianApi.updateDietitian(d1);
    expect(d1, d1);
  });

  test("Delete dietitian", () {
    dietitianApi.deleteDietitian(d1.uid!);
    expect(d1, d1);
  });
}
