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
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message message, options) => message.toFirestore())
        .doc(message.uid)
        .set(message)
        .then((value) => log("Message Added"))
        .catchError((error) {
      log("Failed to add message: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Message> readMessage(String messageId) async {
    final docRef = collectionReference.doc(messageId).withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message msg, _) => msg.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final message = docSnapshot.data();
    if (message != null) {
      return message;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  Future<List<Message>?> readConversation(String firstId, String secondId) async {
    List<String> planet = [firstId, secondId];
    final querySnapshot = await collectionReference
        .where('fromId', whereIn: planet)
        .where('toId', whereIn: planet)
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, _) => msg.toFirestore()
        ).get();
    final messages = querySnapshot.docs.map((doc) => doc.data()).toList();
    return messages;
  }

  @override
  void updateMessage(Message message) {
    collectionReference
        .doc(message.uid)
        .update(message.toFirestore())
        .then((value) => log("Message Updated"))
        .catchError((error) {
      log("Failed to update message: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteMessage(String messageId) {
    collectionReference.doc(messageId).delete();
  }
}
