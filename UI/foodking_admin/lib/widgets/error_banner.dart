import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onClose;
  const ErrorBanner({super.key, required this.message, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.shade700,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}
