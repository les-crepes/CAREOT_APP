import 'package:pdg_app/model/message.dart';

abstract class IMessage {
  void createMessage(Message message);
  Future<Message> readMessage(String messageId);
  Future<List<Message>?> readConversation(String firstId, String secondId);
  void updateMessage(Message message);
  void deleteMessage(String messageId);
  Stream<Message?> followConversation(String firstId, String secondId);
}
