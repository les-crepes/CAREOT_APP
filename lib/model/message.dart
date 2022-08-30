import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Message implements IModel {
  @override
  String uid = const Uuid().v1();
  DateTime? time;
  String? fromId;
  String? toId;
  String? content;
  int? type;

  Message({
    String? uid,
    this.time,
    this.fromId,
    this.toId,
    this.content,
    this.type,
  }) : uid = uid ?? const Uuid().v1();

  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Message(
      uid: data?['uid'],
      time: data?['time'],
      fromId: data?['fromId'],
      toId: data?['toId'],
      content: data?['content'],
      type: data?['type'],
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
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Message{$fromId $toId $content $type}';
  }

  void setContent(String newContent) {
    content = newContent;
  }
}
