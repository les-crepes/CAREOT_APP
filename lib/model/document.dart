class Document {
  String? url;

  Document(
      {this.url});

  factory Document.fromJson(Map<String, dynamic> document) {
    return Document(
      url: document['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

  @override
  String toString() {
    return 'Document{$url}';
  }

}
