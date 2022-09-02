import 'dart:io';

abstract class IFile {
  void uploadFile(String filepath);
  void downloadFile(String fileUrl);
  void updateFile(String fileName);
  void deleteFile(String fileId);
}
