import 'api.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../firebase_options.dart';

class FirebaseApi implements Api {
  CollectionReference aftercares =
      FirebaseFirestore.instance.collection('aftercare');
  CollectionReference clients = FirebaseFirestore.instance.collection('client');
  CollectionReference documents =
      FirebaseFirestore.instance.collection('document');
  CollectionReference meals = FirebaseFirestore.instance.collection('meal');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');
  CollectionReference dieticians =
      FirebaseFirestore.instance.collection('dietician');

  @override
  createAftercare() {
    // TODO: implement createAfterCare
    throw UnimplementedError();
  }

  @override
  createClient() {
    clients
        .add({
          'firstName': 'a',
          'lastName': 'b',
          'birthDate': 'c',
          'phoneNumber': 'd',
          'insurance': 'e'
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  createDocument() {
    // TODO: implement createDocument
    throw UnimplementedError();
  }

  @override
  createMeal() {
    // TODO: implement createMeal
    throw UnimplementedError();
  }

  @override
  createMessage() {
    // TODO: implement createMessage
    throw UnimplementedError();
  }

  @override
  createDietician() {
    // TODO: implement createDietician
    throw UnimplementedError();
  }

  @override
  deleteAftercare() {
    // TODO: implement deleteAftercare
    throw UnimplementedError();
  }

  @override
  deleteClient() {
    // TODO: implement deleteClient
    throw UnimplementedError();
  }

  @override
  deleteDocument() {
    // TODO: implement deleteDocument
    throw UnimplementedError();
  }

  @override
  deleteMeal() {
    // TODO: implement deleteMeal
    throw UnimplementedError();
  }

  @override
  deleteMessage() {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  deleteDietician() {
    // TODO: implement deleteDietician
    throw UnimplementedError();
  }

  @override
  readAftercare() {
    // TODO: implement readAftercare
    throw UnimplementedError();
  }

  @override
  readClient() {
    // TODO: implement readClient
    throw UnimplementedError();
  }

  @override
  readDocument() {
    // TODO: implement readDocument
    throw UnimplementedError();
  }

  @override
  readMeal() {
    // TODO: implement readMeal
    throw UnimplementedError();
  }

  @override
  readMessage() {
    // TODO: implement readMessage
    throw UnimplementedError();
  }

  @override
  readDietician() {
    // TODO: implement readDietician
    throw UnimplementedError();
  }

  @override
  signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  updateAftercare() {
    // TODO: implement updateAftercare
    throw UnimplementedError();
  }

  @override
  updateClient() {
    // TODO: implement updateClient
    throw UnimplementedError();
  }

  @override
  updateDocument() {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  @override
  updateMeal() {
    // TODO: implement updateMeal
    throw UnimplementedError();
  }

  @override
  updateMessage() {
    // TODO: implement updateMessage
    throw UnimplementedError();
  }

  @override
  updateDietician() {
    // TODO: implement updateDietician
    throw UnimplementedError();
  }
}
