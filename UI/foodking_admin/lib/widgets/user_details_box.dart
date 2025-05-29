import 'package:flutter/material.dart';
import 'korisnici_list_item.dart';
import '../utils/util.dart';

class UserDetailsBox extends StatelessWidget {
  final UserDetails user;
  final String? testBase64Image;

  // Provided user image in Base64
  static const String _testBase64Image =
      "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";

  const UserDetailsBox({
    super.key,
    required this.user,
    this.testBase64Image = _testBase64Image,
  });

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
          // Right: Base64 image or fallback
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
                  child: testBase64Image != null && testBase64Image!.isNotEmpty
                      ? ClipOval(
                          child: imageFromBase64String(
                            testBase64Image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : (user.photoUrl != null && user.photoUrl!.isNotEmpty
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
                            )),
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
