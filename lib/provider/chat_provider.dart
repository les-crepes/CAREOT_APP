import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdg_app/api/firebase_message.dart';
import 'package:sorted_list/sorted_list.dart';

import '../api/firebase_user.dart';
import '../api/imessage.dart';
import '../api/iuser.dart';
import '../model/message.dart';
import '../model/user.dart';
import 'auth_provider.dart';

typedef Uid = String;

class ChatProvider extends ChangeNotifier {
  /// Getting the instance of the AuthProvider class.
  final AuthProvider _auth;
  final IMessage _messageApi = FirebaseMessage(FirebaseFirestore.instance);
  final IUser _userApi = FirebaseUser(FirebaseFirestore.instance);

  /// The list of messages using a [LinkedHashMap] to keep the order of the messages.
  final Map<User, SortedList<Message>> _messages = {};

  ChatProvider(AuthProvider authProvider) : _auth = authProvider;

  /// Returning an unmodifiable list view of the messages.
  UnmodifiableListView<Message> getMessagesWith(String uid) {
    final messages = _messages[uid];
    if (messages != null) {
      return UnmodifiableListView(messages);
    }
    return UnmodifiableListView([]);
  }

  /// Fetching all the messages from the database.
  Future<void> fetchAllMessages() async {
    List<User> users = [];

    if (_auth.isAdmin) {
      final clients = await _userApi.getDietitianClient(_auth.userUid);
      users.addAll(clients);
    } else {
      final diet = await _userApi.readDietitianOfClient(_auth.userUid);
      if (diet != null) {
        users.add(diet);
      }
    }
    final List<Future<List<Message>?>> functions = [];
    for (final user in users) {
      functions.add(_messageApi.readConversation(_auth.userUid, user.uid));
    }

    final futureResult = await Future.wait(functions);

    int index = 0;
    for (final conv in futureResult) {
      final sortedList =
          SortedList<Message>((a, b) => a.time.compareTo(b.time));

      sortedList.addAll(conv!);

      _messages[users[index]] = sortedList;
      index++;
    }
    log(_messages.toString());
  }
}
