// dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/providers/basket_provider.dart';
import 'package:customer_app/models/basket_item.dart';
import 'checkout_screen.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketProvider>(
      builder: (context, basket, _) {
        final items = basket.items;
        return Scaffold(
          appBar: AppBar(title: const Text('Košarica')),
          body: items.isEmpty
              ? const Center(child: Text('Košarica je prazna'))
              : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    final BasketItem it = items[idx];
                    final bytes = it.product.imageBytes;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            bytes != null
                                ? Image.memory(bytes, width: 64, height: 64, fit: BoxFit.cover)
                                : Container(width: 64, height: 64, color: Colors.grey[300], child: const Icon(Icons.image)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(it.product.title, style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 6),
                                  Text('${it.product.price.toStringAsFixed(2)} KM', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    final newQty = (it.quantity - 1);
                                    if (newQty <= 0) {
                                      basket.removeProduct(it.product.id);
                                    } else {
                                      basket.setQuantity(it.product.id, newQty);
                                    }
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                                  child: Text('${it.quantity}'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => basket.setQuantity(it.product.id, it.quantity + 1),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => basket.removeProduct(it.product.id),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ukupno:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${basket.totalPrice.toStringAsFixed(2)} KM', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: items.isEmpty
                                ? null
                                : () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen()));
                            },
                            child: const Text('Na naplatu'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: items.isEmpty
                              ? null
                              : () {
                            basket.clear();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Košarica je očišćena')));
                          },
                          child: const Text('Isprazni'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// local import to avoid circular import issues when replacing files
// put CheckoutScreen in its own file (see `lib/screens/checkout_screen.dart`)
