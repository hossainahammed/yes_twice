import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          // 1. TOP LEFT GLOW
          Positioned(
            top: -74.h,
            left: -150.w,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
              child: Container(
                width: 290.w,
                height: 202.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7F7F).withOpacity(0.7),
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(290.w, 202.h),
                  ),
                ),
              ),
            ),
          ),

          // 2. CONTENT
          child,
        ],
      ),
    );
  }
}
