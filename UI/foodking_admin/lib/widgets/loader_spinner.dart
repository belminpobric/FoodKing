import 'package:flutter/material.dart';

class LoaderSpinner extends StatelessWidget {
  final double size;
  final Color? color;
  const LoaderSpinner({super.key, this.size = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).primaryColor),
          strokeWidth: 4,
        ),
      ),
    );
  }
}
