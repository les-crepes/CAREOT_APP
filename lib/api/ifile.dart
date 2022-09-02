import 'dart:io';

abstract class IFile {
  Future<String> uploadFile(String filepath);
  void downloadFile(String fileUrl);
  void updateFile(String fileName);
  void deleteFile(String fileId);
}
