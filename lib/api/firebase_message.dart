import 'dart:developer';

import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMessage implements IMessage {
  FirebaseMessage._();
  static final FirebaseMessage _instance = FirebaseMessage._();
  factory FirebaseMessage() => _instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');

  @override
  void createMessage(Message message) {
    messages
        .add(message.toJson())
        .then((value) => log("Message Added"))
        .catchError((error) {
      log("Failed to add message: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteMessage(String messageId) {
    messages.doc(messageId).delete();
  }

  @override
  Future<Message> readMessage(String messageId) async {
    final docRef = messages.doc(messageId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Message.fromJson(data);
  }

  @override
  updateMessage(Message message) {
    messages
        .doc('FAKE')
        .update(message.toJson())
        .then((value) => log("Message Updated"))
        .catchError((error) {
      log("Failed to update message: $error");
      throw Exception(error);
    });
  }
}
