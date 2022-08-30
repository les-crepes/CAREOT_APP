abstract class IModel {
  Map<String, dynamic> toFirestore();
  String get uid;
}