import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdg_app/api/exceptions.dart';

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

  StorageException getStorageExceptionFromCode(String code) {
    switch (code) {
      case 'cloud_firestore/not-found':
        return StorageException(StorageExceptionType.notFound);
      case 'cloud_firestore/permission-denied':
        return StorageException(StorageExceptionType.permissionDenied);
      case 'cloud_firestore/aborted':
        return StorageException(StorageExceptionType.aborted);
      case 'cloud_firestore/already-exists':
        return StorageException(StorageExceptionType.alreadyExists);
      case 'cloud_firestore/canceled':
        return StorageException(StorageExceptionType.canceled);
      case 'cloud_firestore/deadline-exceeded':
        return StorageException(StorageExceptionType.deadlineExceeded);
      case 'cloud_firestore/unavailable':
        return StorageException(StorageExceptionType.unavailable);
      default:
        return StorageException(StorageExceptionType.unknown);
    }
  }
}
