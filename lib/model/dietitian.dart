import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/model/user.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Dietitian extends User implements IModel {

  List? clientList;

  Dietitian(
      {String? uid,
      this.clientList,
      required String firstName,
      required String lastName,
      required DateTime birthDate,
      required String phoneNumber,
      required String avs,
      required String email}
      ) : super(
    uid: uid ?? const Uuid().v1(),
    firstName: firstName,
    lastName: lastName,
    birthDate: birthDate,
    phoneNumber: phoneNumber,
    avs: avs,
    email: email,
  );

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
      birthDate: data?['birthDate'].toDate(),
      phoneNumber: data?['phoneNumber'],
      email: data?['email'],
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
      'phoneNumber': phoneNumber,
      'avs': avs,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Dietitian{$firstName $lastName $clientList $avs $phoneNumber $birthDate}';
  }
}
