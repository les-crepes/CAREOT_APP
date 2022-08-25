class Message {
  DateTime? time;
  DateTime? fromId;
  String? toId;
  List? content;
  String? type;

  Message({
    this.time,
    this.fromId,
    this.toId,
    this.content,
    this.type,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      time: message['time'],
      fromId: message['fromId'],
      toId: message['toId'],
      content: message['content'],
      type: message['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'fromId': fromId,
      'toId': toId,
      'content': content,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'Message{$fromId $toId $content $type}';
  }
}
