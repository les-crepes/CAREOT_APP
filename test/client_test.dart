import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/api/firebase_client.dart';
import 'package:pdg_app/model/client.dart';
import 'package:pdg_app/model/dietitian.dart';

final db = FakeFirebaseFirestore();
Client c1 = Client(
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0780001223',
    birthDate: DateTime.now(),
    insurance: '');
Client c2 = Client(
    firstName: 'Chloé',
    lastName: 'Fontaine',
    phoneNumber: '0780002334',
    birthDate: DateTime.now(),
    insurance: '');
Client c3 = Client(
    firstName: 'Luca',
    lastName: 'Coduri',
    phoneNumber: '0780003445',
    birthDate: DateTime.now(),
    insurance: '');
Client c4 = Client(
    firstName: 'Nelson',
    lastName: 'Jeanrenaud',
    phoneNumber: '0786834556',
    birthDate: DateTime.now(),
    insurance: '');
Dietitian d1 = Dietitian(
    firstName: 'Claire',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '',
    clientList: [c2.uid, c3.uid, c4.uid]);

Future<void> populateMockClient(Client c) async {
  await db.collection('client').doc(c.uid).set(c.toFirestore());
}

Future<void> populateMockDietitian(Dietitian d) async {
  await db.collection('dietitian').doc(d.uid).set(d.toFirestore());
}

void main() {
  late IClient clientApi;
  final clients = db.collection('client');

  setUp(() async {
    populateMockClient(c2);
    populateMockClient(c3);
    populateMockClient(c4);
    populateMockDietitian(d1);
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

  test("getDietitianClients", () async {
    List<Client> coco = [c2, c3, c4];
    final clients = await clientApi.getDietitianClient(d1.uid);
    expect(clients.elementAt(0).toString(), coco.elementAt(0).toString());
  });
}
