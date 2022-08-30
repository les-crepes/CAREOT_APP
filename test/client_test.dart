import 'dart:developer';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/api/firebase_client.dart';
import 'package:pdg_app/model/client.dart';

final db = FakeFirebaseFirestore();
Client c1 = Client(
    firstName: 'Olivier', lastName: 'D\'Ancona', phoneNumber: '0780001223');
Client c2 =
    Client(firstName: 'Chloé', lastName: 'Fontaine', phoneNumber: '0780002334');
Client c3 =
    Client(firstName: 'Luca', lastName: 'Coduri', phoneNumber: '0780003445');
Client c4 = Client(
    firstName: 'Nelson', lastName: 'Jeanrenaud', phoneNumber: '0786834556');

void populateMockClient(Client c) async {
  await db.collection('client').add(c.toFirestore());
}

void main() {
  late IClient clientApi;
  final clients = db.collection('client');

  setUp(() async {
    populateMockClient(c1);
    populateMockClient(c2);
    populateMockClient(c3);
    populateMockClient(c4);
    clientApi = FirebaseClient(db);
  });

  test("Create Client", () async {
    clientApi.createClient(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    log(c2!.uid);
    log(c1.uid);

    expect(c1.toString(), c2.toString());
  });

  test("Read Client", () async {
    final Client c1Bis = await clientApi.readClient(c1.uid);
    expect(c1.toString(), c1Bis.toString());
  });

  test("Update client", () async {
    c1.setFirstName('Filippo');
    clientApi.updateClient(c1);
    final c2 = await db.doc(c1.uid).get();
    expect(c1, c2);
  });

  test("Delete client", () {
    clientApi.deleteClient(c1.uid);
    expect(db.doc(c1.uid), null);
  });
}
