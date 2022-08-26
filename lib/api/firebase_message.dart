import 'dart:developer';

import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/model/message.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseMessage implements IMessage {
  FirebaseMessage._();
  static final FirebaseMessage _instance = FirebaseMessage._();
  factory FirebaseMessage() => _instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void createMessage(Message message) async {
    DatabaseReference ref = database.ref("message");

    await ref.set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }

  @override
  void deleteMessage(String messageId) {
    //database.ref(messageId).delete();
  }

  @override
  Future<Message> readMessage(String messageId) async {
    final doc = await database.ref('message').get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.value as Map<String, dynamic>;
    return Message.fromJson(data);
  }

  @override
  updateMessage(Message message) {
    database
        .ref('FAKE')
        .update(message.toJson())
        .then((value) => log("Message Updated"))
        .catchError((error) {
      log("Failed to update message: $error");
      throw Exception(error);
    });
  }
}
