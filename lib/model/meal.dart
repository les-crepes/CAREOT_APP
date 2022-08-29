import 'imodel.dart';

class Meal implements IModel {
  DateTime? startTime;
  DateTime? endTime;
  String? lastName;
  List? photo;
  String? hunger;
  String? satiety;
  String? setting;
  String? comment;

  Meal(
      {this.startTime,
      this.endTime,
      this.lastName,
      this.photo,
      this.satiety,
      this.hunger,
      this.setting,
      this.comment});

  factory Meal.fromJson(Map<String, dynamic> meal) {
    return Meal(
      startTime: meal['startTime'],
      endTime: meal['endTime'],
      lastName: meal['lastName'],
      photo: meal['photo'],
      satiety: meal['satiety'],
      hunger: meal['hunger'],
      setting: meal['setting'],
      comment: meal['comment'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'lastName': lastName,
      'photo': photo,
      'hunger': hunger,
      'satiety': satiety,
      'setting': setting,
      'comment': comment,
    };
  }

  @override
  String toString() {
    return 'Meal{$endTime $lastName $photo $satiety $hunger}';
  }
}
