import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/foodKing_button.dart';

class UserDetails {
  final String username;
  final String fullName;
  final String address;
  final String currentAddress;
  final String phone;
  final String email;
  final String? photoUrl;

  UserDetails({
    required this.username,
    required this.fullName,
    required this.address,
    required this.currentAddress,
    required this.phone,
    required this.email,
    this.photoUrl,
  });
}

class KorisniciListItem extends StatelessWidget {
  final String text;
  final VoidCallback onDetailsPressed;

  const KorisniciListItem({
    super.key,
    required this.text,
    required this.onDetailsPressed,
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
          Expanded(
            flex: 3,
            child: FoodKingButton(
              buttonColor: Colors.blue,
              text: "Detalji",
              textColor: Colors.white,
              onPressed: onDetailsPressed,
            ),
          ),
        ],
      ),
    );
  }
}
