import 'package:flutter/material.dart';

class CustomListTileData {
  final Widget? avatar;
  final String? title;
  final String? subtitle;
  final DateTime? date;
  final int? badgeCount;
  final void Function()? onTap;

  CustomListTileData({
    this.avatar,
    this.title,
    this.subtitle,
    this.date,
    this.badgeCount,
    this.onTap,
  });
}
