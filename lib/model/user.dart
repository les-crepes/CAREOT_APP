import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class User implements IModel {
  String uid;
  String firstName;
  String lastName;
  DateTime birthDate;
  String phoneNumber;
  String avs;
  String? profilePicture;

  User(
      { String? uid,
        required this.firstName,
        required this.lastName,
        required this.birthDate,
        required this.phoneNumber,
        required this.avs,
        this.profilePicture}
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
      phoneNumber: data?['phoneNumber'],
      avs: data?['avs'],
      profilePicture: data?['profilePicture'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'avs': avs,
      'profilePicture': profilePicture,
    };
  }

  @override
  String toString() {
    return 'User{$firstName $lastName $birthDate $phoneNumber $avs}';
  }

  void setFirstName(String name) {
    firstName = name;
  }

}