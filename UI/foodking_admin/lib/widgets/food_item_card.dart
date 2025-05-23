import 'package:flutter/material.dart';

class FoodItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int rating; // out of 5
  final VoidCallback onOrder;
  final VoidCallback? onIconPressed;
  final IconData? icon;

  const FoodItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.onOrder,
    this.onIconPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EFF4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.deepOrange,
                    size: 20,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton(
                onPressed: onOrder,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  side: const BorderSide(color: Colors.teal),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text("Naruči"),
              ),
              const Spacer(),
              Text(
                "${price.toStringAsFixed(2)} KM",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              if (icon != null) ...[
                const SizedBox(width: 16),
                CircleAvatar(
                  backgroundColor: Colors.orange.shade200,
                  radius: 20,
                  child: IconButton(
                    icon: Icon(icon, color: Colors.deepOrange),
                    onPressed: onIconPressed,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
