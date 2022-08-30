import 'dart:developer';

import 'package:pdg_app/api/idocument.dart';
import 'package:pdg_app/model/document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDocument implements IDocument {
  FirebaseDocument._();
  static final FirebaseDocument _instance = FirebaseDocument._();
  factory FirebaseDocument() => _instance;
  CollectionReference documents =
      FirebaseFirestore.instance.collection('document');
  final storage = FirebaseStorage.instance;

  @override
  void createDocument(Document document, String fileName) {
    //final file = storage.ref().child(fileName);
    documents
        .add(document.toFirestore())
        .then((value) => log("Document Added"))
        .catchError((error) {
      log("Failed to add document: $error");
      throw Exception(error);
    });
  }

  @override
  void deleteDocument(String documentId) {
    documents.doc(documentId).delete();
  }

  @override
  Future<Document> readDocument(String documentId) async {
    final docRef = documents.doc(documentId);
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Error();
    }
    final data = doc.data() as Map<String, dynamic>;
    return Document.fromJson(data);
  }

  @override
  updateDocument(Document document) {
    documents
        .doc('FAKE')
        .update(document.toFirestore())
        .then((value) => log("Document Updated"))
        .catchError((error) {
      log("Failed to update document: $error");
      throw Exception(error);
    });
  }
}
