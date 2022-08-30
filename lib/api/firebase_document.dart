import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAPI {
  final FirebaseFirestore firestore;
  final CollectionReference collectionReference;

  FirebaseAPI(FirebaseFirestore db, String collectionName)
      : firestore = db,
        collectionReference = db.collection(collectionName);
}
