import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/firebase_api.dart';
import 'package:pdg_app/api/firebase_dietitian.dart';
import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/api/idietitian.dart';
import 'package:pdg_app/model/client.dart';
import 'package:pdg_app/model/dietitian.dart';

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

  @override
  Future<List<Client>> getDietitianClient(String dietitianId) async {
    IDietitian dietitianApi = FirebaseDietitian(super.getDb());
    Dietitian d = await dietitianApi.readDietitian(dietitianId);
    final m =
        await collectionReference.where("uid", whereIn: d.clientList).get();
    List<Client> clients = m.docs
        .map((doc) => Client(
            birthDate: doc['birthDate'].toDate(),
            firstName: doc['firstName'],
            insurance: doc['insurance'],
            lastName: doc['lastName'],
            phoneNumber: doc['phoneNumber'],
            uid: doc['uid']))
        .toList();
    return clients;
  }
}
