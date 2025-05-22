import 'package:flutter/material.dart';
import 'toast.dart';

class ToastProvider extends StatefulWidget {
  final Widget child;
  const ToastProvider({super.key, required this.child});

  static _ToastProviderState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ToastProviderState>();

  @override
  State<ToastProvider> createState() => _ToastProviderState();
}

class _ToastProviderState extends State<ToastProvider> {
  OverlayEntry? _overlayEntry;

  void showToast(String message,
      {Color backgroundColor = Colors.black87,
      Color textColor = Colors.white,
      Duration duration = const Duration(seconds: 2)}) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 40,
        left: 0,
        right: 0,
        child: Toast(
            message: message,
            backgroundColor: backgroundColor,
            textColor: textColor),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
