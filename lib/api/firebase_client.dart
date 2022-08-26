import 'dart:developer';

import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/model/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClient implements IClient {
  FirebaseClient._();
  static final FirebaseClient _instance = FirebaseClient._();
  factory FirebaseClient() => _instance;
  CollectionReference clients = FirebaseFirestore.instance.collection('client');

  @override
  void createClient(Client client) {
    clients
        .add(client.toJson())
        .then((value) => log("Client Added"))
        .catchError((error) {
      log("Failed to add client: $error");
      throw Exception(error);
    });
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
  void updateClient(Client client) {
    clients
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
    clients.doc(clientId).delete();
  }
}
