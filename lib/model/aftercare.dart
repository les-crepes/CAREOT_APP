import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'imodel.dart';

class Aftercare implements IModel {
  String uid;
  String clientId;
  int? bmi;
  double? weight;
  String? diagnostic;
  String? comments;
  String? motivations;
  String? foodObjectives;
  DateTime startDate;
  DateTime? endDate;
  List? documents;

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

  factory Aftercare.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    DateTime? stDate;
    if (data?['endDate'] != null) {
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

  void setBmi(int newBmi) {
    bmi = newBmi;
  }
}
