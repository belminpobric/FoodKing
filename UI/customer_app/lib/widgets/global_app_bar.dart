import 'package:flutter/material.dart';
import '../providers/basket_provider.dart';
import '../screens/basket_screen.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  const GlobalAppBar({super.key, this.title, this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    final basketCount = BasketProvider.of(context).basketCount;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.orange),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLogo)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 36,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.fastfood,
                      size: 28,
                      color: Colors.orange),
                ),
              ),
            ),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
        ],
      ),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_basket, color: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BasketScreen()),
                );
              },
            ),
            if (basketCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$basketCount',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
