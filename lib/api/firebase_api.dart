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

  DatabaseException getDatabaseExceptionFromCode(String code) {
    switch (code) {
      case 'cloud_firestore/not-found':
        return DatabaseException(DatabaseExceptionType.notFound);
      case 'cloud_firestore/permission-denied':
        return DatabaseException(DatabaseExceptionType.permissionDenied);
      case 'cloud_firestore/aborted':
        return DatabaseException(DatabaseExceptionType.aborted);
      case 'cloud_firestore/already-exists':
        return DatabaseException(DatabaseExceptionType.alreadyExists);
      case 'cloud_firestore/canceled':
        return DatabaseException(DatabaseExceptionType.canceled);
      case 'cloud_firestore/deadline-exceeded':
        return DatabaseException(DatabaseExceptionType.deadlineExceeded);
      case 'cloud_firestore/unavailable':
        return DatabaseException(DatabaseExceptionType.unavailable);
      default:
        return DatabaseException(DatabaseExceptionType.unknown);
    }
  }
}
