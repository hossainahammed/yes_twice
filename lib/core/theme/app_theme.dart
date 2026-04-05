import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.light().textTheme),
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade200,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFCA7373),
    scaffoldBackgroundColor: const Color(0xFF141414),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFCA7373),
      surface: Color(0xFF232323),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF141414),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
    iconTheme: const IconThemeData(color: Colors.white70),
    cardColor: const Color(0xFF232323),
    dividerColor: Colors.grey.shade800,
  );
}
