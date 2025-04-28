import 'package:christmas_tree/pages/customize_tree_page.dart';
import 'package:christmas_tree/pages/product_detail_page.dart';
import 'package:christmas_tree/pages/refer_friend_page.dart';
import 'package:christmas_tree/pages/shop_page.dart';
import 'package:christmas_tree/pages/tree_stylist_page.dart';
import 'package:christmas_tree/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:christmas_tree/models/user.dart' show User;
import 'package:christmas_tree/models/product.dart';
import 'package:snow_fall_animation/snow_fall_animation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import '../models/category.dart';
// import '../services/api_service.dart'; // Import your ApiService

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double _santaPosition = -100; // Initial position of Santa (off-screen)
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ApiService _apiService = ApiService(); // Instance of ApiService
  List<Product> _featuredProducts = []; // Initialize as an empty list
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _playChristmasSound();
    _startSantaAnimation();
    _fetchFeaturedProducts(); // Fetch featured products
    _fetchCategories();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startSantaAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _santaPosition += 2; // Move Santa 2 pixels per frame
        if (_santaPosition > MediaQuery.of(context).size.width + 100) {
          _santaPosition = -100; // Reset position when Santa moves off-screen
        }
      });
    });
  }

  void _playChristmasSound() async {
  try {
    print('Loading sound asset...');
    await _audioPlayer.setAsset('assets/sounds/christmas_jingle.mp3'); // Load the sound
    print('Playing sound...');
    _audioPlayer.play(); // Play the sound
  } catch (e) {
    print('Error playing sound: $e'); // Log any errors
  }
}

  void _fetchFeaturedProducts() async {
    try {
      final products = await _apiService.getFeaturedProducts(); // Call API
      setState(() {
        _featuredProducts = products; // Update the state with fetched products
      });
    } catch (e) {
      print('Error fetching featured products: $e'); // Handle errors
    }
  }

  void _fetchCategories() async {
  try {
    final categories = await _apiService.getCategories(); // Call API
    setState(() {
      _categories = categories;
    });
  } catch (e) {
    print('Error fetching categories: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Christmas Decor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFD62828), // Festive Red
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_rounded),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF007F5F), // Festive Green
          selectedItemColor: const Color(0xFFFFC300), // Festive Gold
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 0, // Using Container's shadow instead
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              label: 'Design',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildShopContent();
      case 2:
        return _buildDesignContent();
      case 3:
        return _buildProfileContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Banner with gradient, snowfall, and Santa animation
        Stack(
          children: [
            // Gradient container
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD62828), // Festive Red
                    Color(0xFF007F5F), // Festive Green
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Snowfall animation
            Positioned.fill(
              child: SnowFallAnimation(
                config: SnowfallConfig(
                  numberOfSnowflakes: 300, // Increase the number of snowflakes
                  speed: 2.0, // Make the snowflakes fall faster
                  useEmoji: true,
                  customEmojis: ['❄️', '❅', '❆'],
                ),
              ),
            ),
            // Centered text
            Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomizeTreePage()),
                  );
                },
                child: Text(
                  'Design Your Dream Tree',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

            // Santa passing by animation
            Positioned(
              top: 120, // Adjust Santa's vertical position
              left: _santaPosition,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.asset('assets/images/santa.png'), // Santa image
              ),
            ),
          ],
        ),

        // Categories Row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD62828), // Festive Red
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
              height: 100,
              child: _categories.isEmpty 
                  ? Center(child: CircularProgressIndicator()) // or show loading
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryItem(_categories[index]);
                      },
                    ),
            ),

            ],
          ),
        ),

        // Featured Products Section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007F5F), // Festive Green
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _featuredProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(_featuredProducts[index]);
                },
              ),
            ],
          ),
        ),

        // Refer a Friend Section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refer a Friend',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD62828), // Festive Red
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReferFriendPage()),
                  );
                },
                icon: const Icon(Icons.card_giftcard),
                label: const Text('Share the Christmas Spirit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD62828), // Festive Red
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildCategoryItem(Category category) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShopPage(category: category),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFFFC300), // Festive Gold
            child: Icon(
              getCupertinoIcon(category.icon),
              size: 28,
              color: const Color(0xFFD62828), // Festive Red
            ),
          ),
          const SizedBox(height: 4),
          Text(category.name),
        ],
      ),
    ),
  );
}

IconData getCupertinoIcon(String iconName) {
  switch (iconName) {
    case 'tree':
      return CupertinoIcons.tree;
    case 'lightbulb':
      return CupertinoIcons.lightbulb;
    case 'gift':
      return CupertinoIcons.gift;
    case 'socks':
      return CupertinoIcons.cube_box; // Cupertino doesn't have socks, used cube_box for now
    case 'star':
      return CupertinoIcons.star_fill;
    case 'sparkles':
      return CupertinoIcons.sparkles;
    default:
      return CupertinoIcons.circle; // default fallback
  }
}

  Widget _buildCategoryItemOld(String emoji, String name, int categoryId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopPage(
              category: Category(
                categoryId: categoryId,
                name: name,
                description: 'Description for $name',
                icon: emoji,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFFFFC300), // Festive Gold
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 4),
            Text(name),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: const Color(0xFFD62828), // Festive Red
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          Text(
            widget.user.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          // Refer a Friend Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.card_giftcard),
              label: const Text('Refer a Friend'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD62828), // Festive Red
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReferFriendPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Sign Out Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007F5F), // Festive Green
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Logout logic
              },
              child: const Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopContent() {
    return const ShopPage(); // Directly use the ShopPage widget
  }

  Widget _buildDesignContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customize Your Christmas Tree',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomizeTreePage()),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Start Designing'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Need Help from a Stylist?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TreeStylistPage(),
                ),
              );
            },
            icon: const Icon(Icons.design_services),
            label: const Text('Book a Stylist'),
          ),
        ],
      ),
    );
  }
}

