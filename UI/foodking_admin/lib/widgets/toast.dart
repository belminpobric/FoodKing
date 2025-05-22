import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  const Toast(
      {super.key,
      required this.message,
      this.backgroundColor = Colors.black87,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
