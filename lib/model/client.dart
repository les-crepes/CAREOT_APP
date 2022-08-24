class Client {
  String firstName;
  String lastName;
  String birthDate;
  String phoneNumber;
  String insurance;

  Client(
      {required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.insurance,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'insurance': insurance,
    };
  }
}
