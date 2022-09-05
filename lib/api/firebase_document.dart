import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:pdg_app/api/ifile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


class FirebaseFile implements IFile {

  static const maxFileSize = 20 * 1024 * 1024; // 20 MB

  late final FirebaseStorage bucket;
  late final storageRef = bucket.ref();

  FirebaseFile(this.bucket);

  /// Uploads the file to the firebase storage under a specific path. with a unique name.
  @override
  Future<String> uploadFile(String filepath) async {
    File file = File(filepath);
    String fileName = const Uuid().v4();
    final fileRef = storageRef.child(fileName);
    try {
      await fileRef.putFile(file);
      log("File uploaded successfully");
      return fileRef.fullPath;
    } on FirebaseException catch (e) {
      log("Failed to upload file: $e");
      throw Exception(e);
    }
  }

  /// Deletes the file from the firebase storage.
  @override
  void deleteFile(String fileURL) async {
    log('deleteFile: $fileURL');
    final fileId = bucket.refFromURL(fileURL).name;
    final ref = storageRef.child(fileId);
    await ref.delete();
  }

  /// Downloads the file from the firebase storage.
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
