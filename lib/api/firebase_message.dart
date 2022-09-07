import 'dart:developer';

import 'package:pdg_app/api/imessage.dart';
import 'package:pdg_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exceptions.dart';
import 'firebase_api.dart';
import 'package:async/async.dart' show StreamGroup;

/// Implementation of the [IMessage] API interface for Firebase.
class FirebaseMessage extends FirebaseAPI implements IMessage {
  FirebaseMessage(FirebaseFirestore db) : super(db, 'message');

  @override
  void createMessage(Message message) {
    try {
      collectionReference
          .withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message message, options) => message.toFirestore())
          .doc(message.uid)
          .set(message);
      log("Message Added");
    } on FirebaseException catch (e) {
      throw super.getDatabaseExceptionFromCode(e.code);
    }
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
      throw DatabaseException(DatabaseExceptionType.notFound);
    }
  }

  @override
  Future<List<Message>?> readConversation(
      String userId1, String userId2) async {
    try {
      /// Get messages from user1 to user2
      final query = collectionReference
          .where('fromId', isEqualTo: userId1)
          .where('toId', isEqualTo: userId2)
          .withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message msg, _) => msg.toFirestore())
          .get();

      /// Get messages from user2 to user1
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
    } on FirebaseException catch (e) {
      throw super.getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  Stream<Message?> followConversation(String firstId, String secondId) {
    try {
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
    } on FirebaseException catch (e) {
      throw super.getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  void updateMessage(Message message) {
    try {
      collectionReference
          .doc(message.uid)
          .update(message.toFirestore());
    } on FirebaseException catch (e) {
      throw super.getDatabaseExceptionFromCode(e.code);
    }
  }

  @override
  void deleteMessage(String messageId) {
    try {
      collectionReference.doc(messageId).delete();
    } on FirebaseException catch (e) {
      throw super.getDatabaseExceptionFromCode(e.code);
    }
  }
}
