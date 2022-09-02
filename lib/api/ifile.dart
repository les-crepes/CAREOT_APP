import 'dart:io';
import 'dart:typed_data';

abstract class IFile {
  Future<String> uploadFile(String filepath);
  Future<File> downloadFile(String fileId, String downloadPath);
  Future<Uint8List?> downloadFileBytes(String fileId);
  void deleteFile(String fileURL);
}
