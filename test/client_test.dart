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

Future<void> populateMockClient(Client c) async {
  await db.collection('client').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IClient clientApi;
  final clients = db.collection('client');

  setUp(() async {
    populateMockClient(c2);
    populateMockClient(c3);
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
    final client = docSnapshot.data();
    expect(c1.toString(), client.toString());
  });

  test("Read Client", () async {
    final Client c2Bis = await clientApi.readClient(c2.uid);
    expect(c2.toString(), c2Bis.toString());
  });

  test("Update client", () async {
    c1.setFirstName('Filippo');
    clientApi.updateClient(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.firstName);
  });

  test("Delete client", () async {
    clientApi.deleteClient(c3.uid);
    final docSnapshot = await clients
        .doc(c3.uid)
        .withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client client, _) => client.toFirestore(),
        )
        .get();
    final client = docSnapshot.data();
    expect(client, null);
  });
}
