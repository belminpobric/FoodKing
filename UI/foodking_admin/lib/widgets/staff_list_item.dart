import 'package:flutter/material.dart';

class StaffDetails {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  StaffDetails({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });
}

class StaffListItem extends StatelessWidget {
  final String text;

  const StaffListItem({
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
