import 'dart:typed_data';

abstract class IFile {
  Future<String> uploadFile(String filepath);
  Future<Uint8List?> downloadFileBytes(String fileURL);
  void deleteFile(String fileURL);
}
