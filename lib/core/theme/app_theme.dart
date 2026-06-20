import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
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
    textTheme: GoogleFonts.manropeTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700, color: AppColors.textColor),
        displayMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: AppColors.textColor),
        titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.5, color: AppColors.subTextColor),
        bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade200,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,

        elevation: 8, // shadow depth
        shadowColor: AppColors.shadow.withOpacity(0.5),
        //FF7F7F
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  ///Colors Used in Dark Mode:
  ///Main Background: #0D0D0D
  ///Surface / Cards: #2C2C2C
  ///Search Bar (Active): #0D0D0D
  ///Highlights (See All): White
  ///Interactive Elements: AppColors.primaryColor (Dark Red)

  // static ThemeData get darkTheme => ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: AppColors.primaryColor,
  //   scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  //   colorScheme: const ColorScheme.dark(
  //     primary: AppColors.primaryColor,
  //     surface: AppColors.darkSurfaceColor,
  //     onSurface: Colors.white,
  //   ),
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: AppColors.darkBackgroundColor,
  //     foregroundColor: Colors.white,
  //     elevation: 0,
  //     iconTheme: IconThemeData(color: Colors.white),
  //   ),
  //   textTheme: GoogleFonts.manropeTextTheme(
  //     TextTheme(
  //       displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700, color: Colors.white),
  //       displayMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.white),
  //       titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white),
  //       titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
  //       bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white70),
  //       bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white70),
  //     ),
  //   ),
  //   iconTheme: const IconThemeData(color: Colors.white),
  //   cardColor: AppColors.darkSurfaceColor,
  //   dividerColor: Colors.grey.shade800,
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: AppColors.primaryColor,
  //       foregroundColor: Colors.white,
  //       elevation: 0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       textStyle: GoogleFonts.poppins(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   ),
  // );
}
