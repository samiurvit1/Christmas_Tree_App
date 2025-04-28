import 'package:christmas_tree/models/category.dart';
import 'package:christmas_tree/models/order.dart';
import 'package:christmas_tree/models/product.dart';
import 'package:christmas_tree/models/user.dart';
import 'package:christmas_tree/services/api_service.dart';
import 'package:flutter/material.dart';
// import 'package:christmas_tree/models/models.dart';

class AppState extends ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  // List<TreeDesign> _designs = [];
  User? _currentUser;
  List<Order> _orders = [];

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  // List<TreeDesign> get designs => _designs;
  User? get currentUser => _currentUser;
  List<Order> get orders => _orders;

  Future<void> loadInitialData(ApiService apiService) async {
    try {
      _products = await apiService.getProducts();
      _categories = await apiService.getCategories();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading initial data: $e');
    }
  }

  Future<void> login(String email, String password, ApiService apiService) async {
    try {
      _currentUser = await apiService.login(email, password);
      notifyListeners();
    } catch (e) {
      debugPrint('Login error: $e');
      rethrow;
    }
  }

  Future<void> createGuestUser(ApiService apiService) async {
    try {
      _currentUser = await apiService.createGuestUser();
      notifyListeners();
    } catch (e) {
      debugPrint('Guest user creation error: $e');
    }
  }

  Future<void> createOrder(Order order, ApiService apiService) async {
    try {
      final newOrder = await apiService.createOrder(order);
      _orders.add(newOrder);
      notifyListeners();
    } catch (e) {
      debugPrint('Order creation error: $e');
      rethrow;
    }
  }
}