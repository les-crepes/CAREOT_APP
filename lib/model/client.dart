import 'imodel.dart';

class Client implements IModel{
  String? uid;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? phoneNumber;
  String? insurance;

  Client(
      {this.uid,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.insurance,
      this.phoneNumber});

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      uid: client['uid'],
      firstName: client['firstName'],
      lastName: client['lastName'],
      birthDate: client['birthDate'],
      insurance: client['insurance'],
      phoneNumber: client['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'insurance': insurance,
    };
  }

  @override
  String toString() {
    return 'Client{$uid $firstName $lastName $birthDate $insurance $phoneNumber}';
  }

}
