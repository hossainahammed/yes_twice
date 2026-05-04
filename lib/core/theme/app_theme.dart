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

  ///Colors Used in Dark Mode:
  ///Main Background: #0D0D0D
  ///Surface / Cards: #2C2C2C
  ///Search Bar (Active): #0D0D0D
  ///Highlights (See All): White
  ///Interactive Elements: AppColors.primaryColor (Dark Red)

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      surface: AppColors.darkSurfaceColor,
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackgroundColor,
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: GoogleFonts.manropeTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: Colors.white, displayColor: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    cardColor: AppColors.darkSurfaceColor,
    dividerColor: Colors.grey.shade800,
  );
}
