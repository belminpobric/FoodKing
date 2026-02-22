// lib/models/menu.dart
import 'product.dart';

class MenuHasProduct {
  final int id;
  final int menuId;
  final int productId;
  final Product product;

  MenuHasProduct({
    required this.id,
    required this.menuId,
    required this.productId,
    required this.product,
  });

  factory MenuHasProduct.fromJson(Map<String, dynamic> json) {
    return MenuHasProduct(
      id: json['id'] ?? 0,
      menuId: json['menuId'] ?? 0,
      productId: json['productId'] ?? 0,
      product: Product.fromJson(Map<String, dynamic>.from(json['product'] ?? {})),
    );
  }
}

class Menu {
  final int id;
  final String title;
  final List<MenuHasProduct> menuHasProducts;

  Menu({
    required this.id,
    required this.title,
    required this.menuHasProducts,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    final rawList = (json['menuHasProducts'] is List) ? (json['menuHasProducts'] as List) : [];
    final products = rawList.map((e) => MenuHasProduct.fromJson(Map<String, dynamic>.from(e))).toList();
    return Menu(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      menuHasProducts: products,
    );
  }
}
