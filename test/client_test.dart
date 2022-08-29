import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/api/firebase_client.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/client.dart';

final db = FakeFirebaseFirestore();
Client c1 = Client(
    uid: '1',
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0780001223');
Client c2 = Client(
    uid: '2',
    firstName: 'Chloé',
    lastName: 'Fontaine',
    phoneNumber: '0780002334');
Client c3 = Client(
    uid: '3', firstName: 'Luca', lastName: 'Coduri', phoneNumber: '0780003445');
Client c4 = Client(
    uid: '4',
    firstName: 'Nelson',
    lastName: 'Jeanrenaud',
    phoneNumber: '0786834556');

void populateMockClient(Client c) async {
  await db.collection('client').add(c.toJson());
}

void main() {
  late final IClient clientApi;

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    populateMockClient(c1);
    populateMockClient(c2);
    populateMockClient(c3);
    populateMockClient(c4);
    clientApi = FirebaseClient();
  });

  test("Create Client", () {
    clientApi.createClient(c1);
    expect(c1, c1);
  });

  test("Read Client", () {
    clientApi.readClient(c1.uid!);
    expect(c1, c1);
  });

  test("Update client", () {
    clientApi.updateClient(c2);
    expect(c1, c1);
  });

  test("Delete client", () {
    clientApi.deleteClient(c1.uid!);
    expect(c1, c1);
  });
}
