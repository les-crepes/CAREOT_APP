import 'dart:developer';

import 'package:pdg_app/api/idocument.dart';
import 'package:pdg_app/model/document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDocument implements IDocument {
  CollectionReference documents =
      FirebaseFirestore.instance.collection('document');

  @override
  void createDocument(Document document) {
    documents
        .add(document.toJson())
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
        .update(document.toJson())
        .then((value) => log("Document Updated"))
        .catchError((error) {
      log("Failed to update document: $error");
      throw Exception(error);
    });
  }
}
