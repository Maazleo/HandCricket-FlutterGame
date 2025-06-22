import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF388E3C),
      scaffoldBackgroundColor: const Color(0xFFF1F8E9),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF388E3C),
        secondary: const Color(0xFF1976D2),
        background: const Color(0xFFF1F8E9),
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.bangersTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        bodyLarge: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.black87,
        ),
        titleLarge: GoogleFonts.lobster(
          fontSize: 28,
          color: const Color(0xFF388E3C),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.bangers(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF388E3C),
        titleTextStyle: GoogleFonts.bangers(
          fontSize: 24,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
    );
  }
} 