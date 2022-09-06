import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

/// Implementation of the [IModel] model interface for the Meal document in Firebase.
class Meal implements IModel {
  String uid; // Unique identifier
  DateTime startTime; // Start time of the meal
  DateTime endTime; // End time of the meal
  String title; // Title of the meal
  String? photo; // URL of the photo of the meal (if any)
  int hunger; // Hunger level before the meal (0-5)
  int satiety; // Satiety level after the meal (0-5)
  String? setting; // Setting of the meal (e.g. home, restaurant, etc.)
  String? comment; // Comment on the meal (if any)
  String owner; // Id of the user who created the meal
  String? photoUrl;

  /// Instantiates a new [Meal].
  /// If [uid] is not provided, a new one is generated.
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

  /// Instantiates a new [Meal] from a Firebase [Map].
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

  /// Set the comment of the meal to the given [newComment]
  void setComment(String newComment) {
    comment = newComment;
  }

  static fromQuery(QueryDocumentSnapshot<Object?> e) {}
}
