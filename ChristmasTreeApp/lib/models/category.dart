class Category {
  final int categoryId;
  final String name;
  final String description;
  final String icon;

  Category({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
