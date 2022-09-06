import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Meal implements IModel {
  String uid;
  DateTime startTime;
  DateTime endTime;
  String title;
  String? photo;
  int hunger;
  int satiety;
  String? setting;
  String? comment;
  String owner;
  String? photoUrl;

  Meal(
      {String? uid,
      required this.startTime,
      required this.endTime,
      required this.title,
      this.photo,
      required this.satiety,
      required this.hunger,
      this.setting,
      this.comment,
      this.photoUrl,
      required this.owner})
      : uid = uid ?? const Uuid().v1();

  factory Meal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Meal(
      uid: data?['uid'],
      startTime: data?['startTime'].toDate(),
      endTime: data?['endTime'].toDate(),
      title: data?['title'],
      photo: data?['photo'],
      satiety: data?['satiety'],
      hunger: data?['hunger'],
      setting: data?['setting'],
      comment: data?['comment'],
      owner: data?['owner'],
      photoUrl: data?['photoUrl'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'startTime': startTime,
      'endTime': endTime,
      'title': title,
      'photo': photo,
      'hunger': hunger,
      'satiety': satiety,
      'setting': setting,
      'comment': comment,
      'owner': owner,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'Meal{$endTime $title $photo $satiety $hunger $owner}';
  }

  void setComment(String newComment) {
    comment = newComment;
  }

  static fromQuery(QueryDocumentSnapshot<Object?> e) {}
}
