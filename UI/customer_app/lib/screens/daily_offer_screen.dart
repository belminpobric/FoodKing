// dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/providers/menu_provider.dart';
import 'package:customer_app/providers/basket_provider.dart';

class DailyOfferScreen extends StatefulWidget {
  const DailyOfferScreen({Key? key}) : super(key: key);

  @override
  State<DailyOfferScreen> createState() => _DailyOfferScreenState();
}

class _DailyOfferScreenState extends State<DailyOfferScreen> {
  final Map<int, int> _qty = {};

  int _qtyFor(int productId) => _qty[productId] ?? 1;

  void _changeQty(int productId, int delta) {
    final cur = _qtyFor(productId);
    final next = (cur + delta).clamp(1, 999);
    setState(() => _qty[productId] = next);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MenuProvider>(create: (_) =>
          MenuProvider()
            ..fetchMenus()),
          // Expect app-level BasketProvider - if not provided above, add it here as well
          ChangeNotifierProvider<BasketProvider>(
              create: (_) => BasketProvider()),
        ],
        child: Scaffold(
            appBar: AppBar(title: const Text('Dnevna ponuda')),
            body: Consumer<MenuProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading)
                  return const Center(child: CircularProgressIndicator());
                if (provider.error != null)
                  return Center(child: Text('Greška: ${provider.error}'));
                if (provider.menus.isEmpty)
                  return const Center(child: Text('Nema ponude'));

                // flatten all products
                final entries = <dynamic>[];
                for (var m in provider.menus) {
                  for (var mhp in m.menuHasProducts) {
                    entries.add({'menu': m, 'mhp': mhp});
                  }
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final menu = entries[i]['menu'];
                    final mhp = entries[i]['mhp'];
                    final product = mhp.product;
                    final Uint8List? bytes = product.imageBytes;
                    final qty = _qtyFor(product.id);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            bytes != null
                                ? Image.memory(
                                bytes, width: 64, height: 64, fit: BoxFit.cover)
                                : Container(
                                width: 64, height: 64, color: Colors.grey[300]),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(menu.title, style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(product.title,
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 6),
                                  Text('${product.price.toStringAsFixed(2)} KM',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            _changeQty(product.id, -1)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(
                                              6)),
                                      child: Text('$qty'),
                                    ),
                                    IconButton(icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            _changeQty(product.id, 1)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Consumer<BasketProvider>(
                                  builder: (context, basket, _) =>
                                      ElevatedButton(
                                        onPressed: () {
                                          basket.addProduct(product, qty);
                                          ScaffoldMessenger
                                              .of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Dodano $qty x ${product
                                                      .title} u košaricu')));
                                        },
                                        child: const Text('Dodaj u košaricu'),
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
        ));
  }
  }
