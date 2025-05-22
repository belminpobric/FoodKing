import 'package:flutter/material.dart';
import 'korisnici_list_item.dart';

class UserDetailsBox extends StatelessWidget {
  final UserDetails user;
  const UserDetailsBox({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Labels and values
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text("Korisničko ime: ${user.username}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Ime i prezime: ${user.fullName}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Adresa stanovanja: ${user.address}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Trenutna adresa stanovanja: ${user.currentAddress}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Broj telefona: ${user.phone}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Email: ${user.email}",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          // Right: Profile picture and label
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: user.photoUrl != null && user.photoUrl!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            user.photoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Fotografija",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
