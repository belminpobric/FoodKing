import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/OrderProvider.dart';
import 'package:foodking_admin/widgets/master_screen.dart';
import 'package:foodking_admin/widgets/order_list_item.dart';
import 'package:foodking_admin/widgets/foodKing_text_field.dart';
import 'package:foodking_admin/models/order.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/screens/order_detail_screen.dart';
import 'package:foodking_admin/utils/pdf_utils.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderProvider _orderProvider;
  List<Order> _orders = [];
  bool _isLoading = true;
  String? _selectedSortBy;
  String? _selectedSortOrder;
  final TextEditingController _searchController = TextEditingController();
  bool _showAcceptedOrders = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _orderProvider = context.read<OrderProvider>();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      setState(() {
        _isLoading = true;
      });

      int? searchId;
      if (_searchController.text.isNotEmpty) {
        searchId = int.tryParse(_searchController.text);
      }

      bool? sortByCreatedAtDesc;
      if (_selectedSortOrder == 'Najnovije') {
        sortByCreatedAtDesc = true;
      } else if (_selectedSortOrder == 'Najstarije') {
        sortByCreatedAtDesc = false;
      }

      final data = await _orderProvider.getOrders(
        isAccepted: _showAcceptedOrders,
        idGTE: searchId,
        sortByCreatedAtDesc: sortByCreatedAtDesc,
      );

      setState(() {
        final List<dynamic> ordersJson = data['result'] ?? [];
        _orders = ordersJson.map((json) => Order.fromJson(json)).toList();
        if (_selectedSortBy != null) {
          _applySorting();
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading orders: $e');
    }
  }

  void _toggleAcceptedOrders() {
    setState(() {
      _showAcceptedOrders = !_showAcceptedOrders;
      _loadOrders();
    });
  }

  void _applySorting() {
    if (_selectedSortBy == null && _selectedSortOrder == null) return;

    switch (_selectedSortBy) {
      case 'Najveca cijena':
        _orders.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'Najniza cijena':
        _orders.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
    }
    // Time sorting
    switch (_selectedSortOrder) {
      case 'Najnovije':
        _orders.sort((a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
        break;
      case 'Najstarije':
        _orders.sort((a, b) =>
            (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
        break;
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedSortBy = null;
      _selectedSortOrder = null;
      _searchController.clear();
      _loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 300,
                      child: FoodKingTextField(
                        labelText: 'ID Narudzbe',
                        controller: _searchController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _loadOrders,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      child: const Text('Pretraga'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Izvještaj se generiše...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    await generateOrdersPdf(
                      _orders,
                      onStart: () {},
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Izvještaj je spreman za preuzimanje!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Preuzmi izvještaj'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      _showAcceptedOrders
                          ? "Prihvaćene narudzbe"
                          : "Neprihvaćene narudzbe",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _toggleAcceptedOrders,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _showAcceptedOrders ? Colors.green : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(_showAcceptedOrders
                          ? "Neprihvaćene narudžbe"
                          : "Prihvaćene narudžbe"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Sortiraj",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedSortBy,
                        underline: const SizedBox(),
                        hint: const Text('Odaberi'),
                        items: ['Najveca cijena', 'Najniza cijena']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSortBy = newValue;
                              _applySorting();
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedSortOrder,
                        underline: const SizedBox(),
                        hint: const Text('Odaberi'),
                        items: ['Najnovije', 'Najstarije'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSortOrder = newValue;
                            });
                            _loadOrders();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _loadOrders,
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Osvježi narudžbe',
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.clear_all),
                      tooltip: 'Očisti filtere',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _orders.isEmpty
                          ? const Center(child: Text('Nema narudžbi'))
                          : ListView.builder(
                              itemCount: _orders.length,
                              itemBuilder: (context, index) {
                                final order = _orders[index];
                                return OrderListItem(
                                  text:
                                      "Order #${order.id ?? 'N/A'} - \$${order.price?.toStringAsFixed(2) ?? '0.00'}",
                                  onDetailsPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailScreen(order: order),
                                      ),
                                    );
                                  },
                                  accepted: order.isAccepted ?? false,
                                  onAccept: () {
                                    // TODO: Implement accept order functionality
                                  },
                                  onReject: () {
                                    // TODO: Implement reject order functionality
                                  },
                                  buttonWidth: 80,
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBarTitle: "Detalji narudzba",
    );
  }
}
