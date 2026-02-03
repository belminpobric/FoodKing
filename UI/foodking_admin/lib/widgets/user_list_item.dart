import 'package:flutter/material.dart';

class UserDetails {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });
}

class UserListItem extends StatelessWidget {
  final String text;

  const UserListItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
