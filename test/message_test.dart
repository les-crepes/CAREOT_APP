import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/api/firebase_message.dart';
import 'package:pdg_app/firebase_options.dart';
import 'package:pdg_app/model/message.dart';

final db = FakeFirebaseFirestore();
Message msg1 =
    Message(content: 'Bonjour', fromId: 'alice', toId: 'bob', id: '');

void populateMockMessage(Message c) async {
  await db.collection('message').add(c.toJson());
}

void main() {
  late final IMessage messageApi;

  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    populateMockMessage(msg1);
    messageApi = FirebaseMessage();
  });

  test("Create Message", () {
    messageApi.createMessage(msg1);
    expect(msg1, msg1);
  });

  test("Read Message", () {
    messageApi.readMessage('fd');
    expect(msg1, msg1);
  });

  test("Update message", () {
    messageApi.updateMessage(msg1);
    expect(msg1, msg1);
  });

  test("Delete message", () {
    messageApi.deleteMessage('');
    expect(msg1, msg1);
  });
}
