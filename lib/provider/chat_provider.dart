import 'dart:async';
import 'dart:collection';

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

/// This class manage the chat data.
class ChatProvider extends ChangeNotifier {
  final AuthProvider _auth;
  final IMessage _messageApi = FirebaseMessage(FirebaseFirestore.instance);
  final IUser _userApi = FirebaseUser(FirebaseFirestore.instance);
  final List<StreamSubscription<Message?>> subcriptions = [];

  /// The list of messages using a [LinkedHashMap] to keep the order of the messages.
  final Map<User, SortedList<Message>> _messages = {};

  ChatProvider(AuthProvider authProvider) : _auth = authProvider;

  Map<User, SortedList<Message>> get messages => UnmodifiableMapView(_messages);

  /// Returning an unmodifiable list view of the messages.
  UnmodifiableListView<Message> getMessagesWithUid(String uid) {
    final messages = _messages[uid];
    if (messages != null) {
      return UnmodifiableListView(messages);
    }
    return UnmodifiableListView([]);
  }

  /// Fetch all messages containing files in a conversation with an [user]
  UnmodifiableListView<Message> getAllFilesOfConversation(User user) {
    final messages = _messages[user];
    if (messages != null) {
      return UnmodifiableListView(
          messages.where((element) => element.fileUrl != null));
    }
    return UnmodifiableListView([]);
  }

  /// It filters the messages to get all last messages of every users.
  UnmodifiableListView<MapEntry<User, Message>> getLastMessageOfEachUser() {
    final result =
        _messages.entries.where((element) => element.value.isNotEmpty).map((e) {
      MapEntry<User, Message> entry = MapEntry(e.key, e.value.first);
      return entry;
    }).toList();
    return UnmodifiableListView(result);
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
          SortedList<Message>((a, b) => b.time.compareTo(a.time));

      sortedList.addAll(conv!);

      _messages[users[index]] = sortedList;
      index++;
    }
    notifyListeners();
  }

  /// send a message
  Future<void> sendMessage(Message message) async {
    _messageApi.createMessage(message);
  }

  /// Start listen to new incoming message.
  void startNewMessageListener() {
    stopNewMessageListener();
    for (final user in _messages.keys) {
      final currentUserUid = _auth.userUid;

      final subscription = _messageApi
          .followConversation(currentUserUid, user.uid)
          .listen((event) {
        /// Be sure that the last received message isn't already in the list.
        if (event != null && !_messages[user]!.any((m) => m.uid == event.uid)) {
          _messages[user]!.add(event);
        }

        notifyListeners();
      });
      subcriptions.add(subscription);
    }
  }

  /// Stop listening to new incoming message.
  void stopNewMessageListener() {
    for (final subscription in subcriptions) {
      subscription.cancel();
    }
  }
}
