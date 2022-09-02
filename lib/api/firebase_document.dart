import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:pdg_app/api/ifile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseFile implements IFile {

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
      return fileName;
    } on FirebaseException catch (e) {
      log("Failed to upload file: $e");
      throw Exception(e);
    }
  }

  @override
  void deleteFile(String fileId) async {
    final ref = storageRef.child(fileId);
    await ref.delete();
  }

  @override
  Future<void> downloadFile(String fileUrl) async {
    // TODO: implement updateFile
  }

  @override
  void updateFile(String fileName) {
    // TODO: implement updateFile
  }
}
