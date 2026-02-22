import 'package:customer_app/models/product.dart';

class BasketItem {
  final Product product;
  int quantity;

  BasketItem({required this.product, required this.quantity});
}
