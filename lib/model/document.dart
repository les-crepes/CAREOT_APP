import 'imodel.dart';

class Document implements IModel {
  String? url;

  Document(
      {this.url});

  factory Document.fromJson(Map<String, dynamic> document) {
    return Document(
      url: document['url'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'url': url,
    };
  }

  @override
  String toString() {
    return 'Document{$url}';
  }

}
