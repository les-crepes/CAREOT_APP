import 'package:flutter/foundation.dart';

abstract class IModel {
  Map<String, dynamic> toJson();
  String toString();
}