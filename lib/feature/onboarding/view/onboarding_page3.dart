import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/app_colors.dart';

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage3({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          const Spacer(flex: 3),
          
          /// ─── Icon ────────────────────────────────────────────────
          Center(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: 140.w,
                  height: 100.w, // Rectangular as per image
                  margin: EdgeInsets.only(bottom: 15.h, left: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Center(
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 28.sp),
                ),
              ],
            ),
          ),
          
          const Spacer(flex: 3),

          /// ─── Title ──────────────────────────────────────────────
          Text(
            'Earn rewards for\nyour reviews',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryColor,
              height: 1.2,
            ),
          ),
          
          SizedBox(height: 24.h),

          /// ─── Description ─────────────────────────────────────────
          Text(
            'Sharing your thoughts pays off! Leave reviews and unlock exclusive perks and rewards.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
              height: 1.5,
            ),
          ),

          const Spacer(flex: 4),

          /// ─── Buttons ────────────────────────────────────────────
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: Size(double.infinity, 56.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
            child: Text(
              'Get Started', // Final onboarding usually has a call to action
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(height: 12.h),
          
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
