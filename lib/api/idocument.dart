import 'package:pdg_app/model/document.dart';

abstract class IDocument {
  void createDocument(Document document, String fileName);
  Future<Document> readDocument(String documentId);
  void updateDocument(Document document);
  void deleteDocument(String documentId);
}