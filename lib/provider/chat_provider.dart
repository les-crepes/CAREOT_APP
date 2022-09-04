import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/message.dart';
import 'auth_provider.dart';

typedef Uid = String;

class ChatProvider extends ChangeNotifier {
  /// Getting the instance of the AuthProvider class.
  final authProvider = GetIt.I.get<AuthProvider>();

  /// The list of messages using a [LinkedHashMap] to keep the order of the messages.
  final SplayTreeSet<Message> _messages = SplayTreeSet<Message>(
    (Message a, Message b) => a.time.compareTo(b.time),
  );

  /// Returning an unmodifiable list view of the messages.
  get messages => UnmodifiableListView(_messages);

  /// `fetchAllMessages()` is an asynchronous function that returns a `Future<void>` and does not take
  /// any arguments
  Future<void> fetchAllMessages() async {}

  ChatProvider();
}
