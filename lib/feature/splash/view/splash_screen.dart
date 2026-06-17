// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:math' as math;
// import '../../../core/constant/app_colors.dart';
// import '../controller/splash_controller.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _sizeAnimation;
//   late Animation<double> _opacityAnimation;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _dotSizeAnimation;
//   late Animation<Offset> _dotMoveAnimation;
//   late Animation<double> _slideUpAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     if (!Get.isRegistered<SplashController>()) {
//       Get.put(SplashController());
//     }
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//
//
//     _slideUpAnimation = Tween<double>(begin: 800.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.25, curve: Curves.easeOutQuart),
//       ),
//     );
//
//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.1, curve: Curves.easeIn),
//       ),
//     );
//
//
//     const blossomingInterval = Interval(0.25, 0.5, curve: Curves.easeOutBack);
//
//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: math.pi / 4,
//     ).animate(CurvedAnimation(parent: _controller, curve: blossomingInterval));
//
//     _sizeAnimation = Tween<double>(
//       begin: 70.0,
//       end: 180.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: blossomingInterval));
//
//
//     _dotSizeAnimation = Tween<double>(begin: 1.0, end: 0.08).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 0.7, curve: Curves.easeInOutExpo),
//       ),
//     );
//
//
//     _dotMoveAnimation =
//         Tween<Offset>(begin: Offset.zero, end: const Offset(98, -1)).animate(
//           CurvedAnimation(
//             parent: _controller,
//             curve: const Interval(0.7, 0.95, curve: Curves.easeOutBack),
//           ),
//         );
//
//     _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.7, 0.95, curve: Curves.easeIn),
//       ),
//     );
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             final value = _controller.value;
//
//             return Stack(
//               alignment: Alignment.center,
//               children: [
//                 if (value < 0.7) ...[
//
//                   Transform.translate(
//                     offset: Offset(0, _slideUpAnimation.value),
//                     child: Opacity(
//                       opacity: _opacityAnimation.value,
//                       child: Transform.rotate(
//                         angle: _rotationAnimation.value,
//                         child: Container(
//                           width:
//                               _sizeAnimation.value *
//                               (value > 0.5 ? _dotSizeAnimation.value : 1.0),
//                           height:
//                               _sizeAnimation.value *
//                               (value > 0.5 ? _dotSizeAnimation.value : 1.0),
//                           decoration: BoxDecoration(
//                             color: value > 0.6
//                                 ? AppColors.primaryColor
//                                 : AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(
//                               _sizeAnimation.value *
//                                   (value > 0.5
//                                       ? _dotSizeAnimation.value
//                                       : 1.0) *
//                                   0.25,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//                 if (value >= 0.7) ...[
//
//                   Opacity(
//                     opacity: _logoOpacityAnimation.value,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'PLTFUL',
//                           style: GoogleFonts.manrope(
//                             color: Colors.white,
//                             fontSize: 48,
//                             fontWeight: FontWeight.w800,
//                             letterSpacing: -1,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Crave. Discover. Experience.',
//                           style: GoogleFonts.manrope(
//                             color: Colors.grey[400],
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Transform.translate(
//                     offset: _dotMoveAnimation.value,
//                     child: Container(
//                       width: 10,
//                       height: 10,
//                       decoration: const BoxDecoration(
//                         color: AppColors.primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
