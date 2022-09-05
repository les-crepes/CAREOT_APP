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
  String email;
  String? photoUrl;
  List? clientList;
  User(
      {String? uid,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.phoneNumber,
      required this.avs,
      required this.email,
      this.clientList,
      this.photoUrl})
      : uid = uid ?? const Uuid().v1();

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
      email: data?['email'],
      photoUrl: data?['photoUrl'],
      clientList: data?['clientList'],
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
      'email': email,
      'photoUrl': photoUrl,
      'clientList': clientList,
    };
  }

  @override
  String toString() {
    return 'User{$firstName $lastName $birthDate $phoneNumber $avs $email}';
  }

  void setFirstName(String name) {
    firstName = name;
  }

  void addUser(String userId) {
    if (clientList == null) {
      throw Exception("Client list is null");
    }
    clientList!.add(userId);
  }
}
