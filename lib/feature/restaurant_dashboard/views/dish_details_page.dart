import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class DishDetailsPage extends StatelessWidget {
  final String name;
  final String rating;
  final String totalReviews;
  final String imagePath;

  const DishDetailsPage({
    super.key,
    required this.name,
    required this.rating,
    required this.totalReviews,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Center(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Get.theme.dividerColor),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: Get.theme.iconTheme.color,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Details",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            SizedBox(height: 24.h),
            Text(
              name,
              style: GoogleFonts.manrope(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: Get.theme.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  rating,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  totalReviews,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "\$\$\$",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Get.theme.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Get.theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Smokehouse brings the bold flavors of Southern-style barbecue to your plate with slow-cooked, fall-off-the-bone meats, house-made sauces, and hearty sides. Known for its signature smoked ribs and pulled pork sandwiches, this casual spot combines rustic charm with mouthwatering comfort food.",
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: Colors.grey.shade400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: true,
                      onChanged: (val) {},
                      activeColor: const Color(0xFFA12C05),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "ACTIVE",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFA12C05),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(imagePath, height: 280.h, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  ImagePath.popularDishes3,
                  height: 85.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  ImagePath.popularDishes2,
                  height: 85.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  ImagePath.popularDishes3,
                  height: 85.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
