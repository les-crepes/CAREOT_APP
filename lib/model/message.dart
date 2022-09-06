import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

/// Implementation of the [IModel] model interface for the Message document in Firebase.
class Message implements IModel {
  String uid = const Uuid().v1(); // Unique identifier
  DateTime time;
  String fromId; // Id of the sender
  String toId; // Id of the receiver
  String content; // Content of the message
  String? fileUrl; // URL of the file attached to the message (if any)

  /// Instantiates a new [Message].
  /// If [uid] is not provided, a new one is generated.
  Message({
    String? uid,
    required this.time,
    required this.fromId,
    required this.toId,
    required this.content,
    this.fileUrl,
  }) : uid = uid ?? const Uuid().v1();

  /// Instantiates a new [Message] from a Firebase [Map].
  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Message(
      uid: data?['uid'],
      time: data?['time'].toDate(),
      fromId: data?['fromId'],
      toId: data?['toId'],
      content: data?['content'],
      fileUrl: data?['fileUrl'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'time': time,
      'fromId': fromId,
      'toId': toId,
      'content': content,
      'fileUrl': fileUrl,
    };
  }

  @override
  String toString() {
    return 'Message{$fromId $toId $content $fileUrl}';
  }

  /// Set the [content] of the message to the given [newContent]
  void setContent(String newContent) {
    content = newContent;
  }
}
