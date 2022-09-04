import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pdg_app/api/firebase_message.dart';

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
  final SplayTreeSet<Message> _messages = SplayTreeSet<Message>(
    (Message a, Message b) => a.time.compareTo(b.time),
  );

  ChatProvider(AuthProvider authProvider) : _auth = authProvider;

  /// Returning an unmodifiable list view of the messages.
  get messages => UnmodifiableListView(_messages);

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

    for (final user in users) {
      _messageApi.readConversation(_auth.userUid, user.uid);
    }
  }
}
