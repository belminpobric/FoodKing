import 'package:flutter/material.dart';
import '../models/order.dart';
import '../widgets/foodKing_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji narudžbe'),
      ),
      body: Center(
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Logo
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 56,
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'FoodKing Logo',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
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
                            const Text('Ime i prezime'),
                            const Text('Adresa'),
                            const Text('Broj telefona'),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FoodKingButton(
                                text: 'Preuzmi izvještaj',
                                onPressed: () {},
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
                  const SizedBox(height: 40),
                  const Text(
                    'Stavke narudžbe',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Placeholder order items
                        const Text(
                            'Stavka 1, cijena stavke 1, sastojci stavke 1'),
                        const Text(
                            'Stavka 2, cijena stavke 2, sastojci stavke 2'),
                        const Text(
                            'Stavka 3, cijena stavke 3, sastojci stavke 3'),
                        const Text(
                            'Stavka 4, cijena stavke 4, sastojci stavke 4'),
                        const Text(
                            'Stavka 5, cijena stavke 5, sastojci stavke 5'),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Cijena bez pdv : 0.00 KM',
                                  style: TextStyle(fontSize: 15)),
                              Text('PDV: 0.00 KM',
                                  style: TextStyle(fontSize: 15)),
                              Text('Total :  0.00 KM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
