import 'dart:developer';

import 'package:pdg_app/api/iclient.dart';
import 'package:pdg_app/model/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';


class FirebaseClient implements IClient {

  static final FirebaseClient _instance = FirebaseClient._(false);
  factory FirebaseClient(bool useFake) {
    if (useFake) {
      return FirebaseClient(true);
    } else {
      return _instance;
    }
  }

  FirebaseClient._(bool useFake) : _db = useFake ? FakeFirebaseFirestore() : FirebaseFirestore.instance,
        _clients = useFake ? FakeFirebaseFirestore().collection('client') : FirebaseFirestore.instance.collection('client');

  final FirebaseFirestore _db;
  final CollectionReference _clients;

  @override
  void createClient(Client client) {
    _clients
        .add(client.toJson())
        .then((value) => log("Client Added"))
        .catchError((error) {
      log("Failed to add client: $error");
      throw Exception(error);
    });
  }

  @override
  Future<Client> readClient(String clientId) async {
    final docRef = _clients.doc(clientId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Client.fromJson(data);
  }

  @override
  void updateClient(Client client) {
    _clients
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
    _clients.doc(clientId).delete();
  }
}
