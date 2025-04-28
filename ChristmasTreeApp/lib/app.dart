import 'package:flutter/material.dart';
import 'package:christmas_tree/pages/home_page.dart';
import 'package:christmas_tree/models/user.dart';

class ChristmasDecorApp extends StatelessWidget {
  const ChristmasDecorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define our custom festive color palette
    const Color festiveRed = Color(0xFFD62828);
    const Color festiveGreen = Color(0xFF007F5F);
    const Color festiveGold = Color(0xFFFFC300);
    const Color darkGreen = Color(0xFF003D2B);

    return MaterialApp(
      title: 'Christmas Decor',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: festiveRed,
          secondary: festiveGreen,
          tertiary: festiveGold,
          surface: Colors.white,
          background: const Color(0xFFF8F5F0), // Light beige background
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black87,
          onSurface: Colors.black87,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: festiveRed,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: festiveGreen,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: festiveGreen,
          selectedItemColor: festiveGold,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 8,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: festiveRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: festiveRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: festiveGreen,
            side: BorderSide(color: festiveGreen),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: festiveGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: festiveGreen, width: 2),
          ),
          labelStyle: TextStyle(color: festiveGreen),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: festiveGold,
          foregroundColor: darkGreen,
        ),
        useMaterial3: true,
      ),
      home: HomePage(user: User(name: "Test", userId: 0, description: "Test", icon: "TestUser")),
      debugShowCheckedModeBanner: false,
    );
  }
}