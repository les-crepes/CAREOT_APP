import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iuser.dart';
import 'package:pdg_app/model/dietitian.dart';
import 'package:pdg_app/model/user.dart';

final db = FakeFirebaseFirestore();
User c1 = User(
    firstName: 'Olivier',
    lastName: 'D\'Ancona',
    phoneNumber: '0780001223',
    birthDate: DateTime.now(),
    avs: '',
  email: 'olivier.dancona@gmail.com');
User c2 = User(
    firstName: 'Chloé',
    lastName: 'Fontaine',
    phoneNumber: '0780002334',
    birthDate: DateTime.now(),
    avs: '',
  email: 'chloe.fontaine@heig-vd.ch');
User c3 = User(
    firstName: 'Luca',
    lastName: 'Coduri',
    phoneNumber: '0780003445',
    birthDate: DateTime.now(),
    avs: '',
    email: 'luca.coduri@heig-vd.ch');
User c4 = User(
    firstName: 'Nelson',
    lastName: 'Jeanrenaud',
    phoneNumber: '0786834556',
    birthDate: DateTime.now(),
    avs: '',
    email: 'nelson.jeanrenaud@heig-vd.ch');
Dietitian d1 = Dietitian(
    firstName: 'Claire',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '',
    clientList: [c2.uid, c3.uid, c4.uid],
    phoneNumber: '',
    email: 'thomas.beil@heig-vd.ch');

Future<void> populateMockClient(User c) async {
  await db.collection('user').doc(c.uid).set(c.toFirestore());
}

Future<void> populateMockDietitian(Dietitian d) async {
  await db.collection('dietitian').doc(d.uid).set(d.toFirestore());
}

void main() {
  late IUser clientApi;
  final clients = db.collection('user');

  setUp(() async {
    populateMockClient(c2);
    populateMockClient(c3);
    populateMockClient(c4);
    populateMockDietitian(d1);
    clientApi = FirebaseUser(db);
  });

  test("Create User", () async {
    clientApi.createUser(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User city, _) => city.toFirestore(),
        )
        .get();
    final user = docSnapshot.data();
    expect(c1.toString(), user.toString());
  });

  test("Read User", () async {
    final User c2Bis = await clientApi.readUser(c2.uid);
    expect(c2.toString(), c2Bis.toString());
  });

  test("Update user", () async {
    c1.setFirstName('Filippo');
    clientApi.updateUser(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.firstName);
  });

  test("Delete user", () async {
    clientApi.deleteUser(c3.uid);
    final docSnapshot = await clients
        .doc(c3.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, _) => user.toFirestore(),
        )
        .get();
    final user = docSnapshot.data();
    expect(user, null);
  });

  test("getDietitianClients", () async {
    List<User> coco = [c2, c3, c4];
    final clients = await clientApi.getDietitianClient(d1.uid);
    expect(clients.elementAt(0).toString(), coco.elementAt(0).toString());
  });
}
