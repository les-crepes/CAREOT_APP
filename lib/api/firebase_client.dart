import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/model/client.dart';

import 'firebase_api.dart';

class FirebaseClient extends FirebaseAPI implements IClient {

  FirebaseClient(FirebaseFirestore db) : super(db, 'client');

  @override
  void createClient(Client client) {
    collectionReference
        .add(client.toJson())
        .then((value) => log("Client Added"))
        .catchError((error) {
      log("Failed to add client: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Client> readClient(String clientId) async {
    final docRef = collectionReference.doc(clientId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Client.fromJson(data);
  }

  @override
  void updateClient(Client client) {
    collectionReference
        .doc('FAKE')
        .update(client.toJson())
        .then((value) => log("Client Updated"))
        .catchError((error) {
      log("Failed to update client: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteClient(String clientId) {
    collectionReference.doc(clientId).delete();
  }
}
