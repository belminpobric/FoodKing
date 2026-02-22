import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/providers/menu_provider.dart';
import 'package:customer_app/providers/basket_provider.dart';
import 'package:customer_app/models/menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Map<int, int> _selectedQty = {}; // productId -> qty

  int _qtyFor(int productId) => _selectedQty[productId] ?? 1;

  void _changeQty(int productId, int delta) {
    final current = _qtyFor(productId);
    final next = (current + delta).clamp(1, 999);
    setState(() => _selectedQty[productId] = next);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuProvider>(create: (_) => MenuProvider()..fetchMenus()),
        ChangeNotifierProvider<BasketProvider>(create: (_) => BasketProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meni'),
          actions: [
            Consumer<BasketProvider>(
              builder: (context, basket, _) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(child: Text('Košarica: ${basket.totalCount}')),
              ),
            )
          ],
        ),
        body: Consumer<MenuProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) return const Center(child: CircularProgressIndicator());
            if (provider.error != null) return Center(child: Text('Greška: ${provider.error}'));
            if (provider.menus.isEmpty) return const Center(child: Text('Nema menija'));

            // flatten products while keeping menu reference for display
            final productEntries = <MapEntry<Menu, dynamic>>[];
            for (var m in provider.menus) {
              for (var mhp in m.menuHasProducts) {
                productEntries.add(MapEntry(m, mhp));
              }
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: productEntries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final menu = productEntries[index].key;
                final mhp = productEntries[index].value;
                final product = mhp.product;
                final Uint8List? bytes = product.imageBytes;
                final qty = _qtyFor(product.id);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        bytes != null
                            ? Image.memory(bytes, width: 64, height: 64, fit: BoxFit.cover)
                            : Container(width: 64, height: 64, color: Colors.grey[300], child: const Icon(Icons.image)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(menu.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(product.title, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 6),
                              Text('${product.price.toStringAsFixed(2)} KM', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => _changeQty(product.id, -1),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                                  child: Text('$qty'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _changeQty(product.id, 1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Consumer<BasketProvider>(
                              builder: (context, basket, _) => ElevatedButton(
                                onPressed: () {
                                  basket.addProduct(product, qty);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Dodano $qty x ${product.title} u košaricu')),
                                  );
                                },
                                child: const Text('Dodaj u košaricu'),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
