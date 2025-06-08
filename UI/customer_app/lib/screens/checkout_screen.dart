import 'package:flutter/material.dart';
import '../providers/basket_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final basketState = BasketProvider.of(context);
    final basket = basketState.basket;
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
    double total = grouped.values
        .fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout',
            style:
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: grouped.isEmpty
                ? const Center(child: Text('Your basket is empty.'))
                : ListView(
                    children: grouped.values
                        .map((item) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange.shade100,
                                child: Text('${item['quantity']}',
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                              ),
                              title: Text(item['title']),
                              subtitle: Text(
                                  '${item['price'].toStringAsFixed(2)} KM'),
                              trailing: Text(
                                  '${(item['price'] * item['quantity']).toStringAsFixed(2)} KM',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                  ),
          ),
          if (basket.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${total.toStringAsFixed(2)} KM',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: grouped.isEmpty
                        ? null
                        : () {
                            // TODO: Implement order placement logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed!')),
                            );
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            basket.clear();
                          },
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
