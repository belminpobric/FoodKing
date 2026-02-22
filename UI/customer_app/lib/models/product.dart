// lib/models/product.dart
import 'dart:convert';
import 'dart:typed_data';

class Product {
  final int id;
  final String title;
  final String? photo; // base64 string
  final double price;

  Product({
    required this.id,
    required this.title,
    this.photo,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      photo: json['photo']?.toString(),
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse('${json['price']}') ?? 0.0,
    );
  }

  /// returns decoded image bytes or null when not available/invalid
  Uint8List? get imageBytes {
    if (photo == null || photo!.isEmpty) return null;
    try {
      return base64Decode(photo!);
    } catch (_) {
      return null;
    }
  }
}
