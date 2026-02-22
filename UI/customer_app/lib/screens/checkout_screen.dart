// dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/providers/basket_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final basket = Provider.of<BasketProvider>(context, listen: false);

    // simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // here you would call backend to create order
    basket.clear();

    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Narudžba je poslana. Hvala!')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Plaćanje')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text('Pregled narudžbe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...basket.items.map((it) => ListTile(
                    leading: it.product.imageBytes != null
                        ? Image.memory(it.product.imageBytes!, width: 48, height: 48, fit: BoxFit.cover)
                        : Container(width: 48, height: 48, color: Colors.grey[300]),
                    title: Text(it.product.title),
                    subtitle: Text('${it.quantity} x ${it.product.price.toStringAsFixed(2)} KM'),
                    trailing: Text('${(it.product.price * it.quantity).toStringAsFixed(2)} KM'),
                  )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Ukupno:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${basket.totalPrice.toStringAsFixed(2)} KM', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(labelText: 'Ime i prezime'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Unesite ime' : null,
                        ),
                        TextFormField(
                          controller: _addressCtrl,
                          decoration: const InputDecoration(labelText: 'Adresa'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Unesite adresu' : null,
                        ),
                        TextFormField(
                          controller: _phoneCtrl,
                          decoration: const InputDecoration(labelText: 'Telefon'),
                          keyboardType: TextInputType.phone,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Unesite telefon' : null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading || basket.items.isEmpty ? null : () => _submit(context),
                  child: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Pošalji narudžbu'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
