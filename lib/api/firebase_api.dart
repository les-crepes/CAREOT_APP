import 'dart:developer';

import 'api.dart';
import '../model/client.dart';

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
  void createClient(Client client) {
    clients
        .add(client.toJson())
        .then((value) => log("User Added"))
        .catchError((error) {
      log("Failed to add user: $error");
      throw Exception(error);
    });
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
  void deleteAftercare(String aftercareId) {
    aftercares.doc(aftercareId).delete();
  }

  @override
  void deleteClient(String clientId) {
    clients.doc(clientId).delete();
  }

  @override
  void deleteDocument(String documentId) {
    documents.doc(documentId).delete();
  }

  @override
  void deleteMeal(String mealId) {
    meals.doc(mealId).delete();
  }

  @override
  void deleteMessage(String messageId) {
    messages.doc(messageId).delete();
  }

  @override
  void deleteDietician(String dieticianId) {
    dieticians.doc(dieticianId).delete();
  }

  @override
  readAftercare() {
    // TODO: implement readAftercare
    throw UnimplementedError();
  }

  @override
  Future<Client> readClient(String clientId) async {
    final docRef = clients.doc(clientId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }

    final data = doc.data() as Map<String, dynamic>;
    return Client.fromJson(data);
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
  void updateClient(Client client) {
    clients
        .doc('FS3RqfWpeuVXcdZrTQJdBPfFbwV2')
        .update({'company': 'Stokes and Sons'})
        .then((value) => log("User Updated"))
        .catchError((error) {
          log("Failed to update user: $error");
          throw Exception(error);
        });
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
