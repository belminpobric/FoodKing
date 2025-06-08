import 'package:flutter/material.dart';
import 'providers/basket_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BasketProvider(child: MyApp()));
}

class BasketProvider extends StatefulWidget {
  final Widget child;
  const BasketProvider({super.key, required this.child});

  static _BasketProviderState of(BuildContext context) {
    final _BasketProviderInherited? inherited =
        context.dependOnInheritedWidgetOfExactType<_BasketProviderInherited>();
    assert(inherited != null,
        'BasketProvider.of() called with a context that does not contain a BasketProvider. Make sure your widget is a descendant of BasketProvider.');
    return inherited!.data;
  }

  @override
  State<BasketProvider> createState() => _BasketProviderState();
}

class _BasketProviderState extends State<BasketProvider> {
  final List<Map<String, dynamic>> _basket = [];

  List<Map<String, dynamic>> get basket => _basket;
  int get basketCount => _basket.length;

  @override
  void initState() {
    super.initState();
    // Add 100 items when the app starts
    for (int i = 0; i < 100; i++) {
      _basket.add({
        'title': 'Item ${i + 1}',
        'ingredients': 'Ingredients for item ${i + 1}',
        'price': (i + 1) * 1.0,
        'rating': 4.0 + (i % 5) * 0.1,
      });
    }
  }

  void addToBasket(Map<String, dynamic> item) {
    setState(() {
      _basket.add(item);
    });
  }

  void removeFromBasket(Map<String, dynamic> item) {
    setState(() {
      _basket.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _BasketProviderInherited(
      data: this,
      child: widget.child,
    );
  }
}

class _BasketProviderInherited extends InheritedWidget {
  final _BasketProviderState data;
  const _BasketProviderInherited({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_BasketProviderInherited oldWidget) => true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodKing',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MenuScreen(),
    const DailyOfferScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    'Menu',
    'Daily Offers',
    'Orders',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
          title: _titles[_selectedIndex], showLogo: _selectedIndex == 0),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  const GlobalAppBar({super.key, this.title, this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    final basketCount = BasketProvider.of(context).basketCount;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.orange),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLogo)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 36,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.fastfood,
                      size: 28,
                      color: Colors.orange),
                ),
              ),
            ),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
        ],
      ),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_basket, color: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BasketScreen()),
                );
              },
            ),
            if (basketCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$basketCount',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Basket',
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
            child: basket.isEmpty
                ? const Center(child: Text('Your basket is empty.'))
                : ListView(
                    children: grouped.values
                        .map((item) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text('${item['title']}'),
                                subtitle: Text(
                                    '${item['price'].toStringAsFixed(2)} KM'),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orange.shade100,
                                  child: Text('${item['quantity']}',
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold)),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    // Remove all of this item from basket
                                    for (int i = basket.length - 1;
                                        i >= 0;
                                        i--) {
                                      if (basket[i]['title'] == item['title']) {
                                        basketState.removeFromBasket(basket[i]);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ))
                        .toList(),
                  ),
          ),
          if (basket.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CheckoutScreen()),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

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
    final basketState = BasketProvider.of(context);

    // Helper to get quantity in basket
    int getQuantity(Map<String, dynamic> item) {
      return basketState.basket
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
                                  basketState.addToBasket(item);
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
                                      final idx = basketState.basket.indexWhere(
                                          (e) => e['title'] == item['title']);
                                      if (idx != -1) {
                                        basketState.removeFromBasket(
                                            basketState.basket[idx]);
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
                                      basketState.addToBasket(item);
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

class DailyOfferScreen extends StatelessWidget {
  const DailyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate 100 test offers
    final List<Map<String, dynamic>> offers = List.generate(
        100,
        (i) => {
              'title': 'Ponuda ${i + 1} - naziv',
              'ingredients': 'Sastojci lista',
              'price': 5.0 + i,
              'rating': 4.0 + (i % 5) * 0.1,
            });
    final basketState = BasketProvider.of(context);

    int getQuantity(Map<String, dynamic> item) {
      return basketState.basket
          .where((e) => e['title'] == item['title'])
          .length;
    }

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final item = offers[index];
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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildRatingStars(item['rating']),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['ingredients'],
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      if (quantity == 0) ...[
                        OutlinedButton(
                          onPressed: () {
                            basketState.addToBasket(item);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange,
                            side: const BorderSide(color: Colors.orange),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 0),
                            minimumSize: const Size(0, 36),
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          child: const Text('Naruči'),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove,
                                  color: Colors.orange),
                              onPressed: () {
                                final idx = basketState.basket.indexWhere(
                                    (e) => e['title'] == item['title']);
                                if (idx != -1) {
                                  basketState.removeFromBasket(
                                      basketState.basket[idx]);
                                }
                              },
                            ),
                            Text('$quantity',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.orange),
                              onPressed: () {
                                basketState.addToBasket(item);
                              },
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(width: 12),
                      Text(
                        '${item['price'].toStringAsFixed(2)} KM',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Example count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${1000 + index}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '3 items • \$${(index + 1) * 15}.99',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ordered on ${DateTime.now().toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'john.doe@example.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            _buildProfileItem(
              context,
              icon: Icons.history,
              title: 'Order History',
              onTap: () {
                // TODO: Navigate to order history
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.favorite,
              title: 'Favorites',
              onTap: () {
                // TODO: Navigate to favorites
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.location_on,
              title: 'Delivery Addresses',
              onTap: () {
                // TODO: Navigate to addresses
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.payment,
              title: 'Payment Methods',
              onTap: () {
                // TODO: Navigate to payment methods
              },
            ),
            _buildProfileItem(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // TODO: Implement logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

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
