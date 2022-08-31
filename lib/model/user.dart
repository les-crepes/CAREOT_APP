import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class User implements IModel {
  String uid;
  String firstName;
  String lastName;
  DateTime birthDate;
  String avs;

  User(
      { String? uid,
        required this.firstName,
        required this.lastName,
        required this.birthDate,
        required this.avs}
      ) : uid = uid ?? const Uuid().v1();

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      uid: data?['uid'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      birthDate: data?['birthDate'].toDate(),
      avs: data?['avs'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'avs': avs,
    };
  }

  @override
  String toString() {
    return 'User{$firstName $lastName $birthDate $avs}';
  }

  void setFirstName(String name) {
    firstName = name;
  }

}