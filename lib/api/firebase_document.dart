import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:pdg_app/api/ifile.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile implements IFile {
  final bucket = FirebaseStorage.instance;
  late final storageRef = bucket.ref();

  @override
  Future<void> uploadFile(File file, int type) async {
    String filePath = (type == 0) ? 'image' : 'file';
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final storageRef = bucket.ref();
    final uploadTask = storageRef.child(filePath).putFile(file, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          log("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          log("Upload is paused.");
          break;
        case TaskState.canceled:
          log("Upload was canceled");
          break;
        case TaskState.error:
          ErrorDescription(" unsuccessful uploads");
          break;
        case TaskState.success:
          log("tata !");
          break;
      }
    });
  }

  @override
  void deleteFile(String fileId) async {
    final ref = storageRef.child(fileId);
    await ref.delete();
  }

  @override
  Future<void> downloadFile(String fileUrl) async {
    final islandRef = storageRef.child(fileUrl);
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/images/island.jpg";
    final file = File(filePath);

    islandRef.writeToFile(file);
  }

  @override
  void updateFile(String fileName) {
    // TODO: implement updateFile
  }
}
