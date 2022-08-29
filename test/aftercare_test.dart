import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/aftercare.dart';

final db = FakeFirebaseFirestore();
Aftercare a1 = Aftercare(bmi: 12, weight: 14.0);


void populateMockAftercare(Aftercare c) async {
  await db.collection('aftercare').add(c.toJson());
}

void main() {
  late final IAftercare aftercareApi;

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    populateMockAftercare(a1);
    aftercareApi = FirebaseAftercare();
  });

  test("Create Aftercare", () {
    aftercareApi.createAftercare(a1);
    expect(a1, a1);
  });

  test("Read Aftercare", () {
    aftercareApi.readAftercare('fd');
    expect(a1, a1);
  });

  test("Update aftercare", () {
    aftercareApi.updateAftercare(a1);
    expect(a1, a1);
  });

  test("Delete aftercare", () {
    aftercareApi.deleteAftercare('');
    expect(a1, a1);
  });
}
