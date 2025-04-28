class User {
  final int userId;
  final String name;
  final String description;
  final String icon;

  User({
    required this.userId,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
