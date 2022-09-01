import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/model/client.dart';

class FirebaseClient extends FirebaseAPI implements IClient {
  FirebaseClient(FirebaseFirestore db) : super(db, 'client');

  @override
  void createClient(Client client) {
    collectionReference
        .withConverter(
            fromFirestore: Client.fromFirestore,
            toFirestore: (Client client, options) => client.toFirestore())
        .doc(client.uid)
        .set(client)
        .then((value) => log("Client Added"))
        .catchError((error) {
      log("Failed to add client: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Client> readClient(String clientId) async {
    final docRef = collectionReference.doc(clientId).withConverter(
          fromFirestore: Client.fromFirestore,
          toFirestore: (Client client, _) => client.toFirestore(),
        );
    final docSnapshot = await docRef.get();
    final client = docSnapshot.data();
    if (client != null) {
      return client;
    } else {
      log("Doc does not exist");
      throw Error();
    }
  }

  @override
  void updateClient(Client client) {
    collectionReference
        .doc(client.uid)
        .update(client.toFirestore())
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
