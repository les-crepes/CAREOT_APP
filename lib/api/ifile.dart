import 'dart:io';

abstract class IFile {
  void uploadFile(File file, int type);
  void downloadFile(String fileUrl);
  void updateFile(String fileName);
  void deleteFile(String fileId);
}
