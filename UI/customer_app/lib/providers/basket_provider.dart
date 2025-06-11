import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _basket = [];

  List<Map<String, dynamic>> get basket => _basket;
  int get basketCount => _basket.length;

  void addToBasket(Map<String, dynamic> item) {
    _basket.add(item);
    notifyListeners();
  }

  void removeFromBasket(Map<String, dynamic> item) {
    _basket.remove(item);
    notifyListeners();
  }

  void clearBasket() {
    _basket.clear();
    notifyListeners();
  }
}
