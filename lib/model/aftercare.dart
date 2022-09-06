import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

/// Implementation of the [IModel] model interface for the Aftercare document in Firebase.
class Aftercare implements IModel {
  String uid; // Unique identifier
  String clientId;
  int? bmi; // Body mass index
  double? weight; // Weight in kg
  String? diagnostic;
  String? comments;
  String? motivations;
  String? foodObjectives;
  DateTime startDate; // Start date of the aftercare
  DateTime? endDate; // End date of the aftercare
  List? documents; // List of documents associated with the aftercare

  /// Instantiates a new [Aftercare].
  /// If [uid] is not provided, a new one is generated.
  Aftercare(
      {String? uid,
      required this.clientId,
      this.bmi,
      this.weight,
      this.diagnostic,
      this.comments,
      this.motivations,
      this.foodObjectives,
      required this.startDate,
      this.endDate,
      this.documents})
      : uid = uid ?? const Uuid().v1();

  /// Instantiates a new [Aftercare] from a Firebase [Map].
  factory Aftercare.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    DateTime? stDate;
    if (data?['endDate'] != null) { // If the end date is not null, convert it to a DateTime
      stDate = data?['endDate'].toDate();
    }
    return Aftercare(
      clientId: data?['clientId'],
      uid: data?['uid'],
      bmi: data?['bmi'],
      weight: data?['weight'],
      diagnostic: data?['diagnostic'],
      comments: data?['comments'],
      motivations: data?['motivations'],
      foodObjectives: data?['foodObjectives'],
      startDate: data?['startDate'].toDate(),
      endDate: stDate,
      documents: data?['documents'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'clientId': clientId,
      'uid': uid,
      'bmi': bmi,
      'weight': weight,
      'diagnostic': diagnostic,
      'comments': comments,
      'motivations': motivations,
      'foodObjectives': foodObjectives,
      'startDate': startDate,
      'endDate': endDate,
      'documents': documents,
    };
  }

  @override
  String toString() {
    return 'Aftercare{ $clientId $bmi $comments $diagnostic $documents $endDate $foodObjectives $motivations $startDate $weight}';
  }

  /// Set the bmi of the aftercare to the given [newBmi]
  void setBmi(int newBmi) {
    bmi = newBmi;
  }
}
