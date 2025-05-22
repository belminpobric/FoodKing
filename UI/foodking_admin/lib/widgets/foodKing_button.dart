import 'package:flutter/material.dart';

class FoodKingButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final IconData? icon;
  final Color textColor;
  final VoidCallback? onPressed;

  const FoodKingButton({
    super.key,
    required this.buttonColor,
    required this.text,
    this.icon,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
