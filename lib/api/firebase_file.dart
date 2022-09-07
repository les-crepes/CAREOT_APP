import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdg_app/api/exceptions.dart';
import 'package:pdg_app/api/ifile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Implementation of [IFile] for firebase storage.
class FirebaseFile implements IFile {

  /// Maximum file download size in bytes.
  static const maxFileSize = 20 * 1024 * 1024; // 20 MB

  late final FirebaseStorage bucket;
  late final storageRef = bucket.ref();

  FirebaseFile(this.bucket);

  @override
  Future<String> uploadFile(String filePath, String storagePath) async {
    File file = File(filePath);
    String fileName = const Uuid().v4(); /// Generate a unique file name.
    final fileRef = storageRef.child('$storagePath$fileName');
    try {
      await fileRef.putFile(file);
      log("File uploaded successfully");
      return await fileRef.getDownloadURL();
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getStorageExceptionFromCode(e.code);
    }
  }

  @override
  void deleteFile(String fileURL) async {
    try {
      log('deleteFile: $fileURL');
      final fileId = bucket.refFromURL(fileURL).name;
      final ref = storageRef.child(fileId);
      await ref.delete();
      log('File deleted');
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getStorageExceptionFromCode(e.code);
    }
  }

  @override
  Future<Uint8List?> downloadFileBytes(String fileURL) async {
    log("downloadFileBytes: $fileURL");
    final ref = bucket.refFromURL(fileURL);
    try {
      return await ref.getData(maxFileSize);
    } on FirebaseException catch (e) {
      log(e.toString());
      throw getStorageExceptionFromCode(e.code);
    }
  }

  /// Convert a [FirebaseException] to a [FileStorageException].
  FileStorageException getStorageExceptionFromCode(String code) {
    switch (code) {
      case 'storage/object-not-found':
        return FileStorageException(FileStorageExceptionType.objectNotFound);
      case 'storage/bucket-not-found':
        return FileStorageException(FileStorageExceptionType.bucketNotFound);
      case 'storage/project-not-found':
        return FileStorageException(FileStorageExceptionType.projectNotFound);
      case 'storage/quota-exceeded':
        return FileStorageException(FileStorageExceptionType.quotaExceeded);
      case 'storage/unauthenticated':
        return FileStorageException(FileStorageExceptionType.unauthenticated);
      case 'storage/unauthorized':
        return FileStorageException(FileStorageExceptionType.unauthorized);
      case 'storage/retry-limit-exceeded':
        return FileStorageException(FileStorageExceptionType.retryLimitExceeded);
      case 'storage/invalid-checksum':
        return FileStorageException(FileStorageExceptionType.invalidChecksum);
      case 'storage/canceled':
        return FileStorageException(FileStorageExceptionType.canceled);
      case 'storage/invalid-event-name':
        return FileStorageException(FileStorageExceptionType.invalidEventName);
      case 'storage/invalid-url':
        return FileStorageException(FileStorageExceptionType.invalidUrl);
      case 'storage/invalid-argument':
        return FileStorageException(FileStorageExceptionType.invalidArgument);
      case 'storage/no-default-bucket':
        return FileStorageException(FileStorageExceptionType.noDefaultBucket);
      case 'storage/cannot-slice-blob':
        return FileStorageException(FileStorageExceptionType.cannotSliceBlob);
      case 'storage/server-file-wrong-size':
        return FileStorageException(FileStorageExceptionType.serverFileWrongSize);
      default:
        return FileStorageException(FileStorageExceptionType.unknown);
    }
  }
}
