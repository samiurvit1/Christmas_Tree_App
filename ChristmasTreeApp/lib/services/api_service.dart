import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../models/user.dart';
// import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.122:5192/api';
  String? authToken;

  Future<List<Product>> getProducts() async {
    try {
      print('Calling API: $baseUrl/products');
      final response = await http.get(Uri.parse('$baseUrl/products'));
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      final url = '$baseUrl/Products/category/$categoryId';
      print('Calling API: $url');
      final response = await http.get(Uri.parse(url));

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products for category $categoryId');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<Product>> getFeaturedProducts() async {
    try {
      print('Calling API: $baseUrl/products/featured');
      final response = await http.get(Uri.parse('$baseUrl/products/featured'));
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load featured products');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    // Mock data - replace with actual API call
    // return [
    //   Category(categoryId: 1, name: 'Trees', icon: '🎄',description: "Trees"),
    //   Category(categoryId: 2, name: 'Lights', icon: '💡',description: "Lights"),
    //   Category(categoryId: 3, name: 'Ornaments', icon: '🎁',description: "Ornaments"),
    //   Category(categoryId: 4, name: 'Stockings', icon: '🧦',description: "Stockings"),
    // ];
    try {
      print('Calling API: $baseUrl/products/categories');
      final response = await http.get(Uri.parse('$baseUrl/products/categories'));
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }

  Future<User> createGuestUser() async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/guest'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Guest user creation failed');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      body: json.encode(order.toJson()),
      headers: {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Order creation failed');
    }
  }
}