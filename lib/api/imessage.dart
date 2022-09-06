import 'package:pdg_app/model/message.dart';

/// Interface for the message API
abstract class IMessage {
  /// Add [message] to the database
  void createMessage(Message message);
  /// Returns the message in the database with [messageId]
  Future<Message> readMessage(String messageId);
  /// Read the messages between the two users [firstId] and [secondId]
  Future<List<Message>?> readConversation(String firstId, String secondId);
  /// Update the [message] in the database
  void updateMessage(Message message);
  /// Delete the message with [messageId] from the database
  void deleteMessage(String messageId);
  /// Subscribe to the messages between the two users [firstId] and [secondId]
  Stream<Message?> followConversation(String firstId, String secondId);
}
