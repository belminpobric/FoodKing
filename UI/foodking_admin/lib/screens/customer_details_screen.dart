import 'package:flutter/material.dart';
import 'package:foodking_admin/models/customer.dart';
import 'package:foodking_admin/widgets/user_details_box.dart';
import 'package:foodking_admin/widgets/korisnici_list_item.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Customer customer;
  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    // Map Customer to UserDetails for the UserDetailsBox
    final userDetails = UserDetails(
      username: customer.email ?? '',
      fullName: '${customer.firstName ?? ''} ${customer.lastName ?? ''}',
      address: '',
      currentAddress: '',
      phone: customer.phoneNumber ?? '',
      email: customer.email ?? '',
      photoUrl: null,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 48,
                ),
                const SizedBox(width: 24),
                const Text(
                  'Detalji o korisniku',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            UserDetailsBox(user: userDetails),
          ],
        ),
      ),
    );
  }
}
