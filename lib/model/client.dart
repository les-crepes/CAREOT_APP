import 'imodel.dart';

class Client implements IModel{
  String? firstName;
  String? lastName;
  String? birthDate;
  String? phoneNumber;
  String? insurance;

  Client(
      {this.firstName,
      this.lastName,
      this.birthDate,
      this.insurance,
      this.phoneNumber});

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      firstName: client['firstName'],
      lastName: client['lastName'],
      birthDate: client['birthDate'],
      insurance: client['insurance'],
      phoneNumber: client['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'insurance': insurance,
    };
  }

  @override
  String toString() {
    return 'Client{$firstName $lastName $birthDate $insurance $phoneNumber}';
  }

}
