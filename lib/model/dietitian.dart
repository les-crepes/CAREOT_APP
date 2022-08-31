import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Dietitian implements IModel {
  String uid;
  String firstName;
  String lastName;
  List? clientList;
  DateTime birthDate;
  String avs;

  Dietitian(
      {String? uid,
      required this.firstName,
      required this.lastName,
      this.clientList,
      required this.avs,
      required this.birthDate})
      : uid = uid ?? const Uuid().v1();

  factory Dietitian.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Dietitian(
      uid: data?['uid'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      clientList: data?['clientList'],
      avs: data?['avs'],
      birthDate: data?['birthDate'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'clientList': clientList,
      'birthDate': birthDate,
      'avs': avs,
    };
  }

  @override
  String toString() {
    return 'Dietitian{$firstName $lastName $clientList $avs $birthDate}';
  }

  void setFirstName(String name) {
    firstName = name;
  }
}
