import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Name",
                        style: GoogleFonts.manrope(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: Get.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: const Color(0xFFA12C05), size: 16.sp),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              "591 Joanne Lane, Wilmington · 2.5 mile",
                              style: GoogleFonts.manrope(
                                fontSize: 13.sp,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.bookmark, color: const Color(0xFF4C080C), size: 24.sp),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                ImagePath.event,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                _buildTag("Event"),
                SizedBox(width: 8.w),
                _buildTag("Eating Food"),
                SizedBox(width: 8.w),
                _buildTag("Flavor Street"),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C080C),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.cached, color: Colors.white, size: 20.sp),
                ),
              ],
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
            SizedBox(height: 20.h),
             Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Get.theme.dividerColor),
              ),
              child: Column(
                children: [
                  _buildInfoRow(Icons.calendar_today_outlined, "21 July, 2025  |  11:30 pm"),
                  SizedBox(height: 16.h),
                  _buildInfoRow(Icons.location_on, "123 Foodie Lane, Johannesburg, SA"),
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
                      value: false,
                      onChanged: (val) {},
                      activeColor: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "HIDE",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
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

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2EF),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 12.sp,
          color: const Color(0xFFA12C05),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFA12C05), size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
