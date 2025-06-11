class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;
  final String email;
  final String photo;
  final String address;
  final String username;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.email,
    required this.photo,
    required this.address,
    required this.username,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String,
      address: json['address'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'photo': photo,
      'address': address,
      'username': username,
    };
  }
}
