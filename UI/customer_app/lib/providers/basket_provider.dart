import 'package:flutter/foundation.dart';
import 'package:customer_app/models/basket_item.dart';
import 'package:customer_app/models/product.dart';

class BasketProvider extends ChangeNotifier {
  final Map<int, BasketItem> _items = {};

  List<BasketItem> get items => _items.values.toList();

  int get totalCount => _items.values.fold(0, (s, it) => s + it.quantity);
  int get basketCount => _items.length;

  double get totalPrice =>
      _items.values.fold(0.0, (s, it) => s + it.product.price * it.quantity);

  void addProduct(Product product, int quantity) {
    if (quantity <= 0) return;
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _items[product.id] = BasketItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void setQuantity(int productId, int quantity) {
    if (!_items.containsKey(productId)) return;
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items[productId]!.quantity = quantity;
    }
    notifyListeners();
  }

  void removeProduct(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
