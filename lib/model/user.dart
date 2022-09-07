import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

/// Implementation of the [IModel] model interface for the User document in Firebase.
class User implements IModel {
  String uid; // Unique identifier
  String firstName;
  String lastName;
  DateTime birthDate;
  String phoneNumber;
  String avs; // Swiss social security number
  String email;
  String? photoUrl; // URL of the user's profile picture
  List<String>?
      clientList; // List of clients of the user, if the user is a dietitian

  /// Instantiates a new [User].
  /// If [uid] is not provided, a new one is generated.
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

  /// Instantiates a new [User] from a Firebase [Map].
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

  /// Change the user's firstname to [name].
  void setFirstName(String name) {
    firstName = name;
  }

  /// Two [User]s are equal if they have the same [uid].
  @override
  bool operator ==(Object other) {
    if (other is User && other.uid == uid) return true;
    return false;
  }

  @override
  int get hashCode => Object.hash(uid, null);

  /// Add a client to the user's client list if [this] is a dietitian.
  void addUser(String userId) {
    if (clientList == null) {
      throw Exception("Client list is null");
    }
    clientList!.add(userId);
  }
}
