import 'imodel.dart';

class Aftercare implements IModel {
  int? bmi;
  double? weight;
  String? diagnostic;
  String? comments;
  String? motivations;
  String? foodObjectives;
  DateTime? startDate;
  DateTime? endDate;
  List? documents;

  Aftercare(
      {this.bmi,
      this.weight,
      this.diagnostic,
      this.comments,
      this.motivations,
      this.foodObjectives,
      this.startDate,
      this.endDate,
      this.documents});

  factory Aftercare.fromJson(Map<String, dynamic> aftercare) {
    return Aftercare(
      bmi: aftercare['bmi'],
      weight: aftercare['weight'],
      diagnostic: aftercare['diagnostic'],
      comments: aftercare['comments'],
      motivations: aftercare['motivations'],
      foodObjectives: aftercare['foodObjectives'],
      startDate: aftercare['startDate'],
      endDate: aftercare['endDate'],
      documents: aftercare['documents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    return 'Aftercare{$bmi $comments $diagnostic $documents $endDate $foodObjectives $motivations $startDate $weight}';
  }
}
