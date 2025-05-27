import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/foodKing_button.dart';

class MenuDetails {
  final String title;
  final String createdAt;
  final String updatedAt;

  MenuDetails({
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
}

class MenuListItem extends StatelessWidget {
  final String text;

  const MenuListItem({
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
