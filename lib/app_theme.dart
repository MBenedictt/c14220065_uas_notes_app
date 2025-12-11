import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Helper function untuk mendapatkan TextTheme berdasarkan nama font
  static TextTheme _getTextTheme(String fontName, Brightness brightness) {
    final baseTextTheme = brightness == Brightness.dark
        ? ThemeData(brightness: Brightness.dark).textTheme
        : ThemeData(brightness: Brightness.light).textTheme;

    switch (fontName) {
      case 'Roboto':
        return GoogleFonts.robotoTextTheme(baseTextTheme);
      case 'Montserrat':
        return GoogleFonts.montserratTextTheme(baseTextTheme);
      case 'Lato':
      default:
        return GoogleFonts.latoTextTheme(baseTextTheme);
    }
  }

  // Tema Terang dengan Kustomisasi
  static ThemeData getLightTheme(String fontName) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );
    final textTheme = _getTextTheme(fontName, Brightness.light);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // Kustomisasi Lanjutan
      cardTheme: CardThemeData(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary, // Gunakan warna dari scheme
          foregroundColor: colorScheme.onPrimary, // Gunakan warna dari scheme
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: colorScheme.primary, // Sorot dengan warna primer
            width: 2.0,
          ),
        ),
      ),
    );
  }

  // Tema Gelap dengan Kustomisasi
  static ThemeData getDarkTheme(String fontName) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark, // Ini penting!
    );
    final textTheme = _getTextTheme(fontName, Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // Kustomisasi Lanjutan
      cardTheme: CardThemeData(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08), // Warna isian sedikit beda
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
      ),
    );
  }
}
