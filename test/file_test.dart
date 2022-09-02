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
    String filepath = await fileApi.uploadFile(getFakeImageFile().path);
    expect(filepath, isNotNull);
  });

  test("Delete file", () async {
    String filepath = await fileApi.uploadFile(getFakeImageFile().path);
    fileApi.deleteFile(filepath);
    expect(storage.storedDataMap.isEmpty, isTrue);
  });

  test("Download file", () async {
    String filename = await fileApi.uploadFile(getFakeImageFile().path);
    File file = await fileApi.downloadFile(filename, './');
    expect(file.path, './$filename');
  });

  test("Download file bytes", () async {
    String filename = await fileApi.uploadFile(getFakeImageFile().path);
    Uint8List? bytes = await fileApi.downloadFileBytes(filename);
    expect(bytes, isNotNull);
    expect(bytes?.length, greaterThan(0));
  });
}
File getFakeImageFile() {
  var fs = MemoryFileSystem();
  final image = fs.file(filename);
  image.writeAsStringSync('contents');
  return image;
}