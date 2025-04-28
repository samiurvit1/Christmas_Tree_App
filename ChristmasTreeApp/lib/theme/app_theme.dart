import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      colorScheme: ColorScheme.light(
        primary: Color(0xFFD62828), // Red
        secondary: Color(0xFF007F5F), // Green
        tertiary: Color(0xFFFFC300), // Gold
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.montserratTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFD62828),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFFD62828),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      colorScheme: ColorScheme.dark(
        primary: Color(0xFFD62828),
        secondary: Color(0xFF007F5F),
        tertiary: Color(0xFFFFC300),
      ),
      scaffoldBackgroundColor: Color(0xFF121212),
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFD62828),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}