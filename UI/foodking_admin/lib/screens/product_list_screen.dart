import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/providers/ProductProvider.dart';

class ProductListScreen extends StatefulWidget {
  final int menuId;
  final String menuTitle;

  const ProductListScreen(
      {super.key, required this.menuId, required this.menuTitle});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _loading = true;
  List<dynamic> _products = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _loading = true);
    try {
      final provider = context.read<ProductProvider>();
      final res = await provider.getProducts(menuId: widget.menuId);
      setState(() {
        _products = res is List ? res : (res['result'] ?? res['Result'] ?? []);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Greška: ${e.toString()}')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stavke za ${widget.menuTitle}')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _products.isEmpty
                ? const Center(child: Text('Nema stavki'))
                : ListView.separated(
                    itemCount: _products.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final p = _products[index] as Map<String, dynamic>;
                      final title = p['title'] ?? p['Title'] ?? '';
                      final price = p['price'] ?? p['Price'] ?? '';
                      final photo = p['photo'] ?? p['Photo'] ?? null;

                      Widget leading = const SizedBox(width: 56);
                      if (photo != null &&
                          photo is String &&
                          photo.isNotEmpty) {
                        try {
                          final bytes = base64Decode(photo);
                          leading = Image.memory(bytes,
                              width: 56, height: 56, fit: BoxFit.cover);
                        } catch (_) {
                          leading = const SizedBox(width: 56);
                        }
                      }

                      return ListTile(
                        leading: leading,
                        title: Text(title.toString()),
                        subtitle: Text('Cijena: ${price.toString()}'),
                      );
                    },
                  ),
      ),
    );
  }
}
