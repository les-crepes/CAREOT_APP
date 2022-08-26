import 'package:pdg_app/model/message.dart';

abstract class IMessage {
  void createMessage(Message message);
  Future<dynamic> readMessage(String messageId);
  void updateMessage(Message message);
  void deleteMessage(String messageId);
}