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
          // Deep muted maroon glow from top-left exactly matching the attached image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.6, // Large soft spread
                colors: [
                  Color(0xFF321517), // Deep muted maroon
                  Colors.black, // Fades into pure black
                ],
                stops: [0.0, 1.0],
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
