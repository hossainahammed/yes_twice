import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteRestaurantPage extends StatelessWidget {
  const DeleteRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Are you sure you want to delete your account? Once you delete your account, all your data including profile information, activity, and saved content will be permanently removed. This action cannot be undone.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: Colors.grey.shade400,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Enter Current Password",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildPasswordField("Enter current password"),
                  SizedBox(height: 40.h),
                  _buildDeleteButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 30.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
            "Delete Restaurant",
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
            ),
          ),
          Icon(Icons.visibility_outlined, color: Colors.grey.shade400, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Request for Delete Restaurant",
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
