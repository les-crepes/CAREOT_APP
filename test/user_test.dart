import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/firebase_user.dart';
import 'package:pdg_app/api/iuser.dart';
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
User d1 = User(
    firstName: 'Claire',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '',
    clientList: [c2.uid, c3.uid],
    phoneNumber: '',
    email: 'claire.emery@gmail.com');
User d2 = User(
    firstName: 'Alice',
    lastName: 'Emery',
    birthDate: DateTime.now(),
    avs: '',
    phoneNumber: '9175097',
    clientList: [c2.uid],
    email: 'olivier.dancona@gmail.com');

Future<void> populateMockUser(User c) async {
  await db.collection('user').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IUser userApi;
  final clients = db.collection('user');

  setUp(() async {
    populateMockUser(c2);
    populateMockUser(c3);
    populateMockUser(c4);
    populateMockUser(d1);
    userApi = FirebaseUser(db);
  });

  test("Create Client", () async {
    userApi.createUser(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, _) => user.toFirestore(),
        )
        .get();
    final user = docSnapshot.data();
    expect(c1.toString(), user.toString());
  });

  test("Create Dietitian", () async {
    userApi.createUser(d2);
    final docSnapshot = await clients
        .doc(d2.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User dietitian, _) => dietitian.toFirestore(),
        )
        .get();
    final dietitian = docSnapshot.data();
    expect(d2.toString(), dietitian.toString());
  });

  test("Read User", () async {
    final User userCopy = await userApi.readUser(d1.uid);
    expect(d1.toString(), userCopy.toString());
  });

  test("Update user", () async {
    c1.setFirstName('Filippo');
    userApi.updateUser(c1);
    final docSnapshot = await clients
        .doc(c1.uid)
        .withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, _) => user.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.firstName);
  });

  test("Delete user", () async {
    userApi.deleteUser(c3.uid);
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
    List<User> coco = [c2, c3];
    final clients = await userApi.getDietitianClient(d1.uid);
    expect(clients.elementAt(0).toString(), coco.elementAt(0).toString());
  });

  test("Read Dietitian of Client", () async {
    final User? dietCopy = await userApi.readDietitianOfClient(c3.uid);
    expect(d1.toString(), dietCopy.toString());
  });

  test("Add Client to dietitian", () async {
    await userApi.addClient("banane", d1.uid);
    final User diet = await userApi.readUser(d1.uid);
    expect(diet.clientList, [c2.uid, c3.uid, "banane"]);
  });
}
