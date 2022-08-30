import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Client implements IModel {
  String uid;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? phoneNumber;
  String? insurance;

  Client(
      {this.firstName,
      this.lastName,
      this.birthDate,
      this.insurance,
      this.phoneNumber})
      : uid = const Uuid().v1();

  factory Client.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Client(
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      birthDate: data?['birthDate'],
      insurance: data?['insurance'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (birthDate != null) 'birthDate': birthDate,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (insurance != null) 'insurance': insurance,
    };
  }

  @override
  String toString() {
    return 'Client{$uid $firstName $lastName $birthDate $insurance $phoneNumber}';
  }

  void setFirstName(String name) {
    firstName = name;
  }
}
