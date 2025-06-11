import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/basket_provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate 100 test menu items
    final List<Map<String, dynamic>> menuItems = List.generate(
        100,
        (i) => {
              'title': 'Stavka ${i + 1} - naziv',
              'ingredients': 'Sastojci lista',
              'price': (i + 1) * 1.0,
              'rating': 4.0 + (i % 5) * 0.1,
            });
    final basketProvider = context.watch<BasketProvider>();

    // Helper to get quantity in basket
    int getQuantity(Map<String, dynamic> item) {
      return basketProvider.basket
          .where((e) => e['title'] == item['title'])
          .length;
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.grey, size: 28),
                ),
                const SizedBox(width: 12),
                const Text(
                  'FoodKing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final quantity = getQuantity(item);
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item['title'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ),
                            _buildRatingStars(item['rating']),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['ingredients'],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            if (quantity == 0) ...[
                              OutlinedButton(
                                onPressed: () {
                                  basketProvider.addToBasket(item);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF00B2A9),
                                  side: const BorderSide(
                                      color: Color(0xFF00B2A9)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 0),
                                  minimumSize: const Size(0, 36),
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                child: const Text('Naruči'),
                              ),
                            ] else ...[
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove,
                                        color: Color(0xFF00B2A9)),
                                    onPressed: () {
                                      // Remove one instance
                                      final idx = basketProvider.basket
                                          .indexWhere((e) =>
                                              e['title'] == item['title']);
                                      if (idx != -1) {
                                        basketProvider.removeFromBasket(
                                            basketProvider.basket[idx]);
                                      }
                                    },
                                  ),
                                  Text('$quantity',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        color: Color(0xFF00B2A9)),
                                    onPressed: () {
                                      basketProvider.addToBasket(item);
                                    },
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(width: 12),
                            Text(
                              '${item['price'].toStringAsFixed(2)} KM',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAE3C2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.comment,
                                    color: Color(0xFFF9A825)),
                                onPressed: () {},
                                iconSize: 22,
                                splashRadius: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Color(0xFFF9A825), size: 18));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(
            const Icon(Icons.star_half, color: Color(0xFFF9A825), size: 18));
      } else {
        stars.add(
            const Icon(Icons.star_border, color: Color(0xFFF9A825), size: 18));
      }
    }
    return Row(children: stars);
  }
}
