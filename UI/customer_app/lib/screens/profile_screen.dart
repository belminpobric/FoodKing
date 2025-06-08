import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'john.doe@example.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            _buildProfileItem(
              context,
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                // TODO: Navigate to order history
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.favorite,
              title: 'Favorites',
              onTap: () {
                // TODO: Navigate to favorites
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.location_on,
              title: 'Delivery Addresses',
              onTap: () {
                // TODO: Navigate to addresses
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.payment,
              title: 'Payment Methods',
              onTap: () {
                // TODO: Navigate to payment methods
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // TODO: Implement logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
