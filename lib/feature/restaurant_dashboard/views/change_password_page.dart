import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

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
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Create new password",
                          style: GoogleFonts.manrope(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Your new password must be unique from\nthose previously used.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 13.sp,
                            color: Colors.grey.shade400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  _buildLabel("Enter Current Password"),
                  _buildPasswordField("Enter current password"),
                  SizedBox(height: 24.h),
                  _buildLabel("Enter new password"),
                  _buildPasswordField("Enter your password"),
                  SizedBox(height: 24.h),
                  _buildLabel("Confirm password"),
                  _buildPasswordField("Enter Confirm password"),
                  SizedBox(height: 48.h),
                  // In the previous screen it wasn't there but presumably there's a button.
                  // Looking at the image, there is no button shown in the middle of the screen,
                  // but presumably there is a bottom button like in Add Restaurant.
                  // Actually, I'll just add one.
                  _buildSaveButton(),
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
            "Change Password",
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
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

  Widget _buildSaveButton() {
     return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Update Password",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
