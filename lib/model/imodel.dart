/// Represent a data model that can be stored in Firebase.
abstract class IModel {
  Map<String, dynamic> toFirestore();
}