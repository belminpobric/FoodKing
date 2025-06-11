import 'package:flutter/material.dart';
import '../models/customer.dart';
import 'base_provider.dart';

class CustomerProvider extends BaseProvider {
  Customer? _customer;
  bool _isLoading = false;
  String? _error;

  CustomerProvider() : super('Customer');

  Customer? get customer => _customer;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCustomer() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await get(queryParams: {'Email': 'test'});
      if (response['result'] is List &&
          (response['result'] as List).isNotEmpty) {
        _customer = Customer.fromJson(response['result'][0]);
      } else {
        _error = 'No customer data found';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCustomer(Customer updatedCustomer) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await post(updatedCustomer.toJson());
      _customer = Customer.fromJson(response);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Customer?> fetchCustomerByEmail(String email) async {
    try {
      final response = await get(queryParams: {'Email': email});
      if (response['result'] is List &&
          (response['result'] as List).isNotEmpty) {
        return Customer.fromJson(response['result'][0]);
      }
    } catch (e) {
      // Optionally log error
    }
    return null;
  }
}
