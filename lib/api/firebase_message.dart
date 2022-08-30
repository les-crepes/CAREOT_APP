import 'dart:developer';

import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';

class FirebaseMessage extends FirebaseAPI implements IMessage {

  FirebaseMessage(FirebaseFirestore db) : super(db, 'message');

  @override
  void createMessage(Message message) {
    collectionReference
        .add(message.toJson())
        .then((value) => log("Message Added"))
        .catchError((error) {
      log("Failed to add message: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteMessage(String messageId) {
    collectionReference.doc(messageId).delete();
  }

  @override
  Future<Message> readMessage(String messageId) async {
    final docRef = collectionReference.doc(messageId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Message.fromJson(data);
  }

  @override
  updateMessage(Message message) {
    collectionReference
        .doc('FAKE')
        .update(message.toJson())
        .then((value) => log("Message Updated"))
        .catchError((error) {
      log("Failed to update message: $error");
      throw Exception(error);
    });
  }
}
