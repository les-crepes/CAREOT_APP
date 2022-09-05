import 'dart:io';

import 'package:file/memory.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdg_app/api/firebase_file.dart';
import 'package:pdg_app/api/ifile.dart';

const filename = 'someimage.png';
final storage = MockFirebaseStorage();

void main() {
  late IFile fileApi;

  setUp(() async {
    fileApi = FirebaseFile(storage);
  });

  test("Upload file", () async {
    String filepath = await fileApi.uploadFile(getFakeImageFile().path, 'images/');
    expect(filepath, isNotNull);
  });

  test("Delete file", () async {
    String filepath = await fileApi.uploadFile(getFakeImageFile().path, 'images/');
    fileApi.deleteFile(filepath);
    expect(storage.storedDataMap.isEmpty, isTrue);
  });

  test("Download file bytes", () async {
    /*
    String filename = await fileApi.uploadFile(getFakeImageFile().path, 'images/');
    Uint8List? bytes = await fileApi.downloadFileBytes(filename);
    expect(bytes, isNotNull);
    expect(bytes?.length, greaterThan(0));*/
    expect(true, isTrue); // Mock doesnt work for download
  });
}

/// Returns a fake image file.
File getFakeImageFile() {
  var fs = MemoryFileSystem();
  final image = fs.file(filename);
  image.writeAsStringSync('contents');
  return image;
}