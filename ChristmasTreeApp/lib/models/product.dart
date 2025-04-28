class Product {
  final int productId;
  final int categoryId;
  final String categoryName;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isEcoFriendly;
  final int stockQuantity;

  Product({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isEcoFriendly,
    required this.stockQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      isEcoFriendly: json['isEcoFriendly'],
      stockQuantity: json['stockQuantity'],
    );
  }
}