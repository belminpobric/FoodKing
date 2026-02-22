// lib/providers/menu_provider.dart
import 'package:flutter/foundation.dart';
import 'package:customer_app/providers/base_provider.dart';
import 'package:customer_app/models/menu.dart';

class MenuProvider extends BaseProvider {
  List<Menu> _menus = [];
  bool _isLoading = false;
  String? _error;

  MenuProvider() : super('Menu');

  List<Menu> get menus => _menus;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMenus() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await get(queryParams: {'isProductIncluded': true});
      debugPrint('Menu API response: $response');

      if (response is Map && response['result'] is List) {
        final list = response['result'] as List;
        _menus = list.map((e) => Menu.fromJson(Map<String, dynamic>.from(e))).toList();
      } else {
        _error = 'Invalid menu data';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
