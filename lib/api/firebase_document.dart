import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
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
    String fileName = Uuid().v4();
    final fileRef = storageRef.child(fileName);
    try {
      await fileRef.putFile(file);
      return fileRef.fullPath;
    } on FirebaseException catch (e) {
      log("Failed to upload file: $e");
      throw Exception(e);
    }
  }

  @override
  void deleteFile(String fileURL) async {
    final fileId = bucket.refFromURL(fileURL).name;
    final ref = storageRef.child(fileId);
    await ref.delete();
  }

  @override
  Future<File> downloadFile(String fileId, String downloadPath) async {
    final ref = storageRef.child(fileId);
    File file = File('$downloadPath/$fileId');
    ref.writeToFile(file);
    return file;
  }

  @override
  Future<Uint8List?> downloadFileBytes(String fileId) async {
    final ref = storageRef.child(fileId);
    try {
      final data = ref.getData(maxFileSize);
      if(data != null) {
        return data;
      } else {
        throw Exception('File not found');
      }
    } on FirebaseException catch (e) {
      log("Failed to download file: $e");
      throw Exception(e);
    }
  }
}
