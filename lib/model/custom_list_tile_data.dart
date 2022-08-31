import 'package:flutter/material.dart';

class CustomListTileData {
  final ImageProvider? avatar;
  final String? title;
  final DateTime? date;
  final int? badgeCount;

  CustomListTileData({
    this.avatar,
    this.title,
    this.date,
    this.badgeCount,
  });
}
