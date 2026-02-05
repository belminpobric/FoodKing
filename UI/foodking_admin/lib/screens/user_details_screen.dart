import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/user_details_box.dart';
import 'package:foodking_admin/widgets/korisnici_list_item.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userJson;
  const UserDetailsScreen({super.key, required this.userJson});

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      return DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final photo =
        (userJson['photo'] is String) ? userJson['photo'] as String : '';

    // If photo looks like base64 (rough check), use it as base64 image.
    final isBase64 =
        photo.isNotEmpty && photo.length > 80 && !photo.startsWith('http');

    final userDetails = UserDetails(
      username: userJson['username'] ?? userJson['userName'] ?? '',
      fullName: '${userJson['firstName'] ?? ''} ${userJson['lastName'] ?? ''}',
      address: userJson['address'] ?? '',
      currentAddress: userJson['currentAddress'] ?? '',
      phone: userJson['phoneNumber'] ?? '',
      email: userJson['email'] ?? '',
      photoUrl: isBase64 ? null : (photo.isNotEmpty ? photo : null),
    );

    final created = userJson['createdAt'] as String?;
    final updated = userJson['updatedAt'] as String?;

    final List<String> roles = [];
    if (userJson['userHasRoles'] is List) {
      for (final r in (userJson['userHasRoles'] as List)) {
        try {
          final name = r?['role']?['name']?.toString();
          if (name != null && name.isNotEmpty) roles.add(name);
        } catch (_) {}
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
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
            // Pass base64 only when detected, otherwise pass empty to show URL/fallback
            UserDetailsBox(
              user: userDetails,
              testBase64Image: isBase64 ? photo : '',
            ),
            const SizedBox(height: 16),
            if (roles.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uloge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        spacing: 8,
                        children:
                            roles.map((r) => Chip(label: Text(r))).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            if (created != null || updated != null) ...[
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
                      if (created != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: 16, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              Text(
                                'Kreiran: ${_formatDate(created)}',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (updated != null)
                        Row(
                          children: [
                            Icon(Icons.edit_outlined,
                                size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(
                              'Ažuriran: ${_formatDate(updated)}',
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
