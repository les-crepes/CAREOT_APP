import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Meal implements IModel {
  @override
  String uid;
  DateTime? startTime;
  DateTime? endTime;
  String? lastName;
  List? photo;
  int? hunger;
  int? satiety;
  String? setting;
  String? comment;

  Meal(
      {String? uid,
      this.startTime,
      this.endTime,
      this.lastName,
      this.photo,
      this.satiety,
      this.hunger,
      this.setting,
      this.comment})
      : uid = uid ?? const Uuid().v1();

  factory Meal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Meal(
      uid: data?['uid'],
      startTime: data?['startTime'],
      endTime: data?['endTime'],
      lastName: data?['lastName'],
      photo: data?['photo'],
      satiety: data?['satiety'],
      hunger: data?['hunger'],
      setting: data?['setting'],
      comment: data?['comment'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'startTime': startTime,
      'endTime': endTime,
      'lastName': lastName,
      'photo': photo,
      'hunger': hunger,
      'satiety': satiety,
      'setting': setting,
      'comment': comment,
    };
  }

  @override
  String toString() {
    return 'Meal{$endTime $lastName $photo $satiety $hunger}';
  }

  void setComment(String newComment) {
    comment = newComment;
  }
}
