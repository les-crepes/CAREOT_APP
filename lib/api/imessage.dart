import 'package:pdg_app/model/message.dart';

abstract class IMessage {
  void createMessage(Message message);
  Future<dynamic> readMessage(String messageId);
  Future<List<dynamic>?> readConversation(String senderId, String receiverId);
  void updateMessage(Message message);
  void deleteMessage(String messageId);
}