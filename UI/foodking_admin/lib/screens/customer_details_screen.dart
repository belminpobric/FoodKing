import 'package:flutter/material.dart';
import 'package:foodking_admin/models/customer.dart';
import 'package:foodking_admin/widgets/user_details_box.dart';
import 'package:foodking_admin/widgets/korisnici_list_item.dart';
import 'package:intl/intl.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Customer customer;
  const CustomerDetailsScreen({super.key, required this.customer});

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = UserDetails(
      username: customer.username ?? '',
      fullName: '${customer.firstName ?? ''} ${customer.lastName ?? ''}',
      address: customer.address ?? '',
      currentAddress: customer.address ?? '',
      phone: customer.phoneNumber ?? '',
      email: customer.email ?? '',
      photoUrl: customer.photo,
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
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
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
            if (customer.createdAt != null || customer.updatedAt != null) ...[
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey.shade700),
                          const SizedBox(width: 8),
                          const Text(
                            'Datumi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (customer.createdAt != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              Text(
                                'Kreiran: ${_formatDate(customer.createdAt!)}',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (customer.updatedAt != null)
                        Row(
                          children: [
                            Icon(Icons.edit_outlined,
                                size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(
                              'Ažuriran: ${_formatDate(customer.updatedAt!)}',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
