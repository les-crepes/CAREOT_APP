import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
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
      return fileRef.getDownloadURL();
    } on FirebaseException catch (e) {
      log("Failed to upload file: $e");
      throw Exception(e);
    }
  }

  @override
  void deleteFile(String fileURL) async {
    log('deleteFile: $fileURL');
    final fileId = bucket.refFromURL(fileURL).name;
    final ref = storageRef.child(fileId);
    await ref.delete();
  }

  @override
  Future<Uint8List?> downloadFileBytes(String fileURL) async {
    log("downloadFileBytes: $fileURL");
    final ref = bucket.refFromURL(fileURL);
    try {
      return await ref.getData(maxFileSize);
    } on FirebaseException catch (e) {
      log("Failed to download file: $e");
      throw Exception(e);
    }
  }
}
