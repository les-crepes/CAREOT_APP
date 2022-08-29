import 'imodel.dart';

class Dietitian implements IModel {
  String? uid;
  String? firstName;
  String? lastName;
  List? clientList;
  String? birthDate;
  String? avs;

  Dietitian(
      {this.uid,
      this.firstName,
      this.lastName,
      this.clientList,
      this.avs,
      this.birthDate});

  factory Dietitian.fromJson(Map<String, dynamic> dietitian) {
    return Dietitian(
      uid: dietitian['uid'],
      firstName: dietitian['firstName'],
      lastName: dietitian['lastName'],
      clientList: dietitian['clientList'],
      avs: dietitian['avs'],
      birthDate: dietitian['birthDate'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
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
