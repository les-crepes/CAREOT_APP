import 'imodel.dart';

class Dietitian implements IModel {
  String? id;
  String? firstName;
  String? lastName;
  List? clientList;
  String? birthDate;
  String? avs;

  Dietitian(
      {this.id,
      this.firstName,
      this.lastName,
      this.clientList,
      this.avs,
      this.birthDate});

  factory Dietitian.fromJson(Map<String, dynamic> dietitian) {
    return Dietitian(
      id: dietitian['id'],
      firstName: dietitian['firstName'],
      lastName: dietitian['lastName'],
      clientList: dietitian['clientList'],
      avs: dietitian['avs'],
      birthDate: dietitian['birthDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'clientList': clientList,
      'birthDate': birthDate,
      'avs': avs,
    };
  }

  @override
  String toString() {
    return 'Dietitian{$firstName $lastName $clientList $avs $birthDate}';
  }

}
