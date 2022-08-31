import 'package:flutter/material.dart';

class ConversationTileData {
  final ImageProvider? avatar;
  final String? title;
  final DateTime? lastMessage;
  final int? unreadCount;

  ConversationTileData({
    this.avatar,
    this.title,
    this.lastMessage,
    this.unreadCount,
  });
}
