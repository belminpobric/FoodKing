import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/foodKing_button.dart';

class OrderListItem extends StatelessWidget {
  final String text;
  final VoidCallback onDetailsPressed;
  final bool accepted;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final double buttonWidth;

  const OrderListItem({
    super.key,
    required this.text,
    required this.onDetailsPressed,
    this.accepted = true,
    this.onAccept,
    this.onReject,
    this.buttonWidth = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (accepted) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "Prihvaćeno",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
          ] else ...[
            const Text(
              "Prihvatiti?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            FoodKingButton(
              buttonColor: Colors.green,
              text: "Da",
              textColor: Colors.white,
              onPressed: onAccept,
              width: buttonWidth,
            ),
            const SizedBox(width: 8),
            FoodKingButton(
              buttonColor: Colors.red,
              text: "Ne",
              textColor: Colors.white,
              onPressed: onReject,
              width: buttonWidth,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            flex: 2,
            child: FoodKingButton(
              buttonColor: Colors.blue,
              text: "Detalji",
              textColor: Colors.white,
              onPressed: onDetailsPressed,
              width: buttonWidth,
            ),
          ),
        ],
      ),
    );
  }
}
