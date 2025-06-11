import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/basket_provider.dart';
import 'checkout_screen.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final basketProvider = context.watch<BasketProvider>();
    final basket = basketProvider.basket;
    // Group items by title and count quantity
    final Map<String, Map<String, dynamic>> grouped = {};
    for (var item in basket) {
      final title = item['title'];
      if (grouped.containsKey(title)) {
        grouped[title]!['quantity'] += 1;
      } else {
        grouped[title] = Map<String, dynamic>.from(item);
        grouped[title]!['quantity'] = 1;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Basket',
            style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...grouped.values
                .map((item) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text('${item['title']}'),
                        subtitle:
                            Text('${item['price'].toStringAsFixed(2)} KM'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: Text('${item['quantity']}',
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold)),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Remove all of this item from basket
                            for (int i = basket.length - 1; i >= 0; i--) {
                              if (basket[i]['title'] == item['title']) {
                                basketProvider.removeFromBasket(basket[i]);
                              }
                            }
                          },
                        ),
                      ),
                    ))
                .toList(),
            if (basket.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CheckoutScreen()),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
