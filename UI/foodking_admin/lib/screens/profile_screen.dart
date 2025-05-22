import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/foodKing_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _imeController = TextEditingController(text: 'belmin');
  final _prezimeController = TextEditingController(text: 'bobric');
  final _korimeController = TextEditingController(text: 'korime1');
  final _emailController = TextEditingController(text: 'belmin.pob@mail.com');
  final _lozinkaController = TextEditingController(text: 'xxxxxxxx');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EFF4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Ime ->'),
                const SizedBox(width: 8),
                Expanded(
                  child: FoodKingTextField(
                    labelText: '',
                    controller: _imeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Prezime ->'),
                const SizedBox(width: 8),
                Expanded(
                  child: FoodKingTextField(
                    labelText: '',
                    controller: _prezimeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Korisnicko ime ->'),
                const SizedBox(width: 8),
                Expanded(
                  child: FoodKingTextField(
                    labelText: '',
                    controller: _korimeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Email ->'),
                const SizedBox(width: 8),
                Expanded(
                  child: FoodKingTextField(
                    labelText: '',
                    controller: _emailController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Lozinka ->'),
                const SizedBox(width: 8),
                Expanded(
                  child: FoodKingTextField(
                    labelText: '',
                    controller: _lozinkaController,
                    isPassword: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Fotografija ->'),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade500,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Upload'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B7A77),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Spasi',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
