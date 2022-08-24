class Dietician {
  String? id;
  String? firstName;
  String? lastName;
  List? clientList;
  String? birthDate;
  String? avs;

  Dietician(
      {this.id,
      this.firstName,
      this.lastName,
      this.clientList,
      this.avs,
      this.birthDate});

  factory Dietician.fromJson(Map<String, dynamic> dietician) {
    return Dietician(
      id: dietician['id'],
      firstName: dietician['firstName'],
      lastName: dietician['lastName'],
      clientList: dietician['clientList'],
      avs: dietician['avs'],
      birthDate: dietician['birthDate'],
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
    return 'Dietician{$firstName $lastName $clientList $avs $birthDate}';
  }

}
