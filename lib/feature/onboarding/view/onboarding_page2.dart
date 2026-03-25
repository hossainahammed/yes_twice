import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/app_colors.dart';

class OnboardingPage2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage2({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          const Spacer(flex: 3),
          
          /// ─── Icon ────────────────────────────────────────────────
          Center(
            child: Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.north_east_rounded, color: AppColors.primaryColor, size: 45.sp),
                    SizedBox(height: 8.h),
                    Container(
                      width: 50.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const Spacer(flex: 3),

          /// ─── Title ──────────────────────────────────────────────
          Text(
            'Share your\nexperience',
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
            'Snap it, rate it, recommend it. Your insights help others explore with confidence.',
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
              'Next',
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
