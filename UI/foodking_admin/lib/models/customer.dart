class Customer {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? photo;
  final String? address;
  final String? username;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.photo,
    this.address,
    this.username,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      photo: json['photo'],
      address: json['address'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'photo': photo,
      'address': address,
      'username': username,
    };
  }
}
