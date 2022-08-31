import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/model/user.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Client extends User implements IModel {
  String phoneNumber;

  Client(
      {String? uid,
      required this.phoneNumber,
      required String firstName,
      required String lastName,
      required DateTime birthDate,
      required String avs}
      ) : super(
    uid: uid ?? const Uuid().v1(),
    firstName: firstName,
    lastName: lastName,
    birthDate: birthDate,
    avs: avs,
  );

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
      avs: data?['avs'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uid': firstName,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'avs': avs,
    };
  }

  @override
  String toString() {
    return 'Client{$firstName $lastName $birthDate $avs $phoneNumber}';
  }
}
