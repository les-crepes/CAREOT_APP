import 'dart:developer';

import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_api.dart';
import 'package:async/async.dart' show StreamGroup;

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
  Future<List<Message>?> readConversation(
      String userId1, String userId2) async {
    final query = collectionReference
        .where('fromId', isEqualTo: userId1)
        .where('toId', isEqualTo: userId2)
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, _) => msg.toFirestore())
        .get();

    final query2 = collectionReference
        .where('fromId', isEqualTo: userId2)
        .where('toId', isEqualTo: userId1)
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, _) => msg.toFirestore())
        .get();

    final querySnapshots = await Future.wait([query, query2]);

    final messages = [
      ...querySnapshots[0].docs.map((doc) => doc.data()).toList(),
      ...querySnapshots[1].docs.map((doc) => doc.data()).toList(),
    ];

    return messages;
  }

  @override
  Stream<Message?> followConversation(String firstId, String secondId) {
    final Stream<QuerySnapshot<Message>> msgStream1 = collectionReference
        .where('fromId', isEqualTo: firstId)
        .where('toId', isEqualTo: secondId)
        .orderBy('time', descending: false)
        .limitToLast(1)
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, _) => msg.toFirestore())
        .snapshots();

    final Stream<QuerySnapshot<Message>> msgStream2 = collectionReference
        .where('fromId', isEqualTo: secondId)
        .where('toId', isEqualTo: firstId)
        .orderBy('time', descending: false)
        .limitToLast(1)
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, _) => msg.toFirestore())
        .snapshots();

    final msgStream =
        StreamGroup.merge<QuerySnapshot<Message>>([msgStream1, msgStream2]);

    return msgStream
        .map((querySnapshot) => querySnapshot.docs)
        .map((doc) => doc.isNotEmpty ? doc.first.data() : null)
        .cast();
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
