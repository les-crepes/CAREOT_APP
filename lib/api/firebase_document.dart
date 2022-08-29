import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class FirebaseDocument {
  final FirebaseFirestore firestore;
  final CollectionReference collectionReference;

  FirebaseDocument(bool useFake, String collectionName)
      : firestore =
            useFake ? FakeFirebaseFirestore() : FirebaseFirestore.instance,
        collectionReference = useFake
            ? FakeFirebaseFirestore().collection(collectionName)
            : FirebaseFirestore.instance.collection(collectionName);
}
