import 'package:flutter/material.dart';
import '../models/order.dart';
import '../widgets/foodKing_button.dart';
import '../utils/pdf_utils.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    final d = dt.toLocal();
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? [];
    final itemsTotal = order.itemsTotal();
    final orderPrice = order.price ?? 0.0;
    final diff = (orderPrice - itemsTotal);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji narudžbe'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Logo + meta
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                height: 56,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Narudžba #${order.id ?? '-'}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text(
                                      'Kreirano: ${_formatDate(order.createdAt)}'),
                                  Text(
                                      'Status: ${order.stateMachine ?? (order.isAccepted == true ? 'Prihvaćena' : 'Nije prihvaćena')}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Right: Customer Info and Download Button
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Podaci o naručiocu :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 12),
                              SelectableText(
                                order.customerName ?? '-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              SelectableText(
                                order.customerAddress ?? '-',
                                style: const TextStyle(fontSize: 13),
                              ),
                              SelectableText(
                                order.customerPhone ?? '-',
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FoodKingButton(
                                  text: 'Preuzmi izvještaj',
                                  onPressed: () async {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Izvještaj se generiše...'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    try {
                                      await generateSingleOrderPdf(order);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Izvještaj je spreman za preuzimanje!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Greška: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  buttonColor: const Color(0xFF2B7A77),
                                  textColor: Colors.white,
                                  width: 160,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Stavke narudžbe',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          if (items.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Nema stavki u narudžbi'),
                            )
                          else
                            Column(
                              children: items.map((it) {
                                final lineTotal =
                                    (it.price ?? 0.0) * (it.quantity ?? 1);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  it.productName ?? '-',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                if (it.description != null &&
                                                    it.description!.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Text(
                                                      it.description!,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: Text(
                                                    'Količina: ${it.quantity ?? 1} × ${(it.price ?? 0.0).toStringAsFixed(2)} KM',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${lineTotal.toStringAsFixed(2)} KM',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(height: 1),
                                  ],
                                );
                              }).toList(),
                            ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        'Cijena stavki: ${itemsTotal.toStringAsFixed(2)} KM'),
                                    Text(
                                        'Razlika / PDV / Ostalo: ${diff.toStringAsFixed(2)} KM'),
                                    const SizedBox(height: 6),
                                    Text(
                                        'Total: ${orderPrice.toStringAsFixed(2)} KM',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
