import 'dart:typed_data';

/// Interface for file storage operations.
abstract class IFile {
  /// Uploads the file located at [filePath] to the firebase storage under [storagePath].
  /// Returns the download URL.
  Future<String> uploadFile(String filePath, String storagePath);
  /// Downloads the file located at [fileURL] from the firebase storage.
  /// Returns the file bytes.
  Future<Uint8List?> downloadFileBytes(String fileURL);
  /// Deletes the file located at [fileURL] from the firebase storage.
  void deleteFile(String fileURL);
}
