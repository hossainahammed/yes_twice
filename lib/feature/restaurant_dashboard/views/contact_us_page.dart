import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("First name"),
                  _buildTextField(Icons.person_outline, "Autumn Phillips"),
                  SizedBox(height: 20.h),
                  _buildLabel("Last name"),
                  _buildTextField(Icons.person_outline, "Kenneth Allen"),
                  SizedBox(height: 20.h),
                  _buildLabel("Email Address"),
                  _buildTextField(Icons.email_outlined, "m.k.freund@aol.com"),
                  SizedBox(height: 20.h),
                  _buildLabel("Description"),
                  _buildTextArea(
                    Icons.description_outlined,
                    "Add description....",
                  ),
                  SizedBox(height: 40.h),
                  _buildSendButton(),
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
          Text(
            "Contact Us",
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Get.theme.textTheme.bodyLarge?.color,
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
          color: Get.theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String initialValue) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(icon, color: Get.theme.iconTheme.color, size: 20.sp),
          hintText: initialValue,
          border: InputBorder.none,
          hintStyle: GoogleFonts.manrope(
            color: Get.theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTextArea(IconData icon, String hint) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.only(top: 4.h),
                hintStyle: GoogleFonts.manrope(
                  color: Colors.grey.shade300,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Get.theme.brightness == Brightness.dark
            ? AppColors.primaryColor
            : const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Send",
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
