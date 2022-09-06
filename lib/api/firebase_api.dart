import 'package:cloud_firestore/cloud_firestore.dart';

/// Manage the connection to the Firebase database.
class FirebaseAPI {
  final FirebaseFirestore firestore;
  final CollectionReference collectionReference;

  FirebaseAPI(FirebaseFirestore db, String collectionName)
      : firestore = db,
        collectionReference = db.collection(collectionName);


  FirebaseFirestore getDb() {
    return firestore;
  }
}
