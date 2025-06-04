class Staff {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  Staff(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.createdAt,
      this.updatedAt});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
