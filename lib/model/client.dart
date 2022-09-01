import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Client implements IModel {
  String uid;
  String firstName;
  String lastName;
  DateTime birthDate;
  String phoneNumber;
  String insurance;

  Client(
      { String? uid,
        required this.firstName,
        required this.lastName,
        required this.birthDate,
        required this.insurance,
        required this.phoneNumber})
      : uid = uid ?? const Uuid().v1();

  factory Client.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Client(
      uid: data?['uid'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      birthDate: data?['birthDate'].toDate(),
      insurance: data?['insurance'],
      phoneNumber: data?['phoneNumber'],
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
      'insurance': insurance,
    };
  }

  @override
  String toString() {
    return 'Client{$firstName $lastName $birthDate $insurance $phoneNumber}';
  }

  void setFirstName(String name) {
    firstName = name;
  }
}
