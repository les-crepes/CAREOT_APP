import 'dart:io';
import 'dart:typed_data';

import 'package:file/memory.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/firebase_document.dart';
import 'package:pdg_app/api/ifile.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';

const filename = 'someimage.png';
final storage = MockFirebaseStorage();

void main() {
  late IFile fileApi;

  setUp(() async {
    fileApi = FirebaseFile(storage);
  });

  test("Upload file", () async {
    String filename = await fileApi.uploadFile(getFakeImageFile().path);
    expect(storage.storedFilesMap.containsKey('/$filename'), isTrue);
  });

  test("Delete file", () async {
    String filename = await fileApi.uploadFile(getFakeImageFile().path);
    String filepath = '/$filename';
    fileApi.deleteFile(filename);
    expect(storage.storedFilesMap.containsKey(filepath), isFalse);
  });
}
File getFakeImageFile() {
  var fs = MemoryFileSystem();
  final image = fs.file(filename);
  image.writeAsStringSync('contents');
  return image;
}