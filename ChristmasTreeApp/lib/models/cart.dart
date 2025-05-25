import 'package:christmas_tree/models/product.dart';

class Cart {
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  void add(Product product) {
    _items.add(product);
  }

  void remove(Product product) {
    _items.remove(product);
  }

  void clear() {
    _items.clear();
  }
}