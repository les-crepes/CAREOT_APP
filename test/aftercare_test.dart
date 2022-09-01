import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/iaftercare.dart';
import 'package:pdg_app/api/firebase_aftercare.dart';
import 'package:pdg_app/model/aftercare.dart';

final db = FakeFirebaseFirestore();
Aftercare a1 = Aftercare(bmi: 12, weight: 14.0, startDate: DateTime.now());
Aftercare a2 = Aftercare(bmi: 13, weight: 14.0, startDate: DateTime.now());

void populateMockAftercare(Aftercare c) async {
  await db.collection('aftercare').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IAftercare aftercareApi;
  final aftercares = db.collection('aftercare');

  setUp(() async {
    populateMockAftercare(a2);
    aftercareApi = FirebaseAftercare(db);
  });

  test("Create Aftercare", () async {
    aftercareApi.createAftercare(a1);
    final docSnapshot = await aftercares
        .doc(a1.uid)
        .withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        )
        .get();
    final aftercare = docSnapshot.data();
    expect(a1.toString(), aftercare.toString());
  });

  test("Read Aftercare", () async {
    final Aftercare a2Bis = await aftercareApi.readAftercare(a2.uid);
    expect(a2.toString(), a2Bis.toString());
  });

  test("Update aftercare", () async {
    a1.setBmi(18);
    aftercareApi.updateAftercare(a1);
    final docSnapshot = await aftercares
        .doc(a1.uid)
        .withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect(18, c2!.bmi);
  });

  test("Delete aftercare", () async {
    aftercareApi.deleteAftercare(a1.uid);
    final docSnapshot = await aftercares
        .doc(a1.uid)
        .withConverter(
          fromFirestore: Aftercare.fromFirestore,
          toFirestore: (Aftercare aftercare, _) => aftercare.toFirestore(),
        )
        .get();
    final aftercare = docSnapshot.data();
    expect(aftercare, null);
  });
}
