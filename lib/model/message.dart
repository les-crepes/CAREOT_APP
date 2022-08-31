import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Message implements IModel {
  String uid = const Uuid().v1();
  DateTime time;
  String fromId;
  String toId;
  String content;
  String? fileUrl;

  Message({
    String? uid,
    required this.time,
    required this.fromId,
    required this.toId,
    required this.content,
    this.fileUrl,
  }) : uid = uid ?? const Uuid().v1();

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

  void setContent(String newContent) {
    content = newContent;
  }
}
