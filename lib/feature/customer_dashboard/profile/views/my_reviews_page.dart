import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    // For demo purposes, checking if reviews exist
    bool hasReviews = true;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'My reviews',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ),
      body: hasReviews
          ? _buildReviewList(context, isDark, textColor, cardColor, subTextColor)
          : _buildEmptyState(textColor),
    );
  }

  Widget _buildReviewList(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color cardColor,
    Color subTextColor,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset(
                        'assets/images/burger.png',
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'KFC Foods',
                            style: GoogleFonts.manrope(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '12 March, 2026',
                            style: GoogleFonts.manrope(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) =>
                            Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                  'The food was very hot, fresh and so delicious. Service was good. Friendly staff and awesome ambience. Everything was fine and perfect...',
                  style: GoogleFonts.manrope(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade300 : Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(Color textColor) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: AppColors.primaryColor, size: 100.sp),
          SizedBox(height: 24.h),
          Text(
            'No reviews are\nadded yet!',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
