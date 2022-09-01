import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/api/firebase_message.dart';
import 'package:pdg_app/model/message.dart';

final db = FakeFirebaseFirestore();
Message msg1 = Message(content: 'Bonjour', fromId: 'alice', toId: 'bob', time: DateTime.now());
Message msg2 = Message(content: 'ciao', fromId: 'alice', toId: 'bob', time:DateTime.now());

Future<void> populateMockMessage(Message c) async {
  await db.collection('message').doc(c.uid).set(c.toFirestore());
}

void main() {
  late IMessage messageApi;
  final messages = db.collection('message');

  setUp(() async {
    populateMockMessage(msg2);
    messageApi = FirebaseMessage(db);
  });

  test("Create Message", () async {
    messageApi.createMessage(msg1);
    final docSnapshot = await messages
        .doc(msg1.uid)
        .withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message message, _) => message.toFirestore(),
        )
        .get();
    final message = docSnapshot.data();
    expect(msg1.toString(), message.toString());
  });

  test("Read Message", () async {
    final Message m2Bis = await messageApi.readMessage(msg2.uid);
    expect(msg2.toString(), m2Bis.toString());
  });

  test("Read Conversation", () async {
    final List? messages = await messageApi.readConversation(msg1.fromId, msg1.toId);
    expect(messages.length, 1);
    expect(messages[0].toString(), msg1.toString());
  });

  test("Update message", () async {
    msg1.setContent('Filippo');
    messageApi.updateMessage(msg1);
    final docSnapshot = await messages
        .doc(msg1.uid)
        .withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message city, _) => city.toFirestore(),
        )
        .get();
    final c2 = docSnapshot.data();
    expect('Filippo', c2!.content);
  });

  test("Delete message", () async {
    messageApi.deleteMessage(msg2.uid);
    final docSnapshot = await messages
        .doc(msg2.uid)
        .withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message city, _) => city.toFirestore(),
        )
        .get();
    final message = docSnapshot.data();
    expect(message, null);
  });
}
