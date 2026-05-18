import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportCenterPage extends StatelessWidget {
  const SupportCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _buildFaqItem(
                  "How do I reset my password?",
                  "To reset your password, visit the login page and click 'Forgot Password'. Follow the email link provided.",
                ),
                SizedBox(height: 12.h),
                _buildFaqItem(
                  "How can I update my account information?",
                  "To update your account information (like email, phone number, or password):\n1. Open your profile settings from the main menu.\n2. Select 'Edit Profile.'\n3. Update your details and save changes.\nYour account will be updated immediately, and you'll be notified if anything is changed.",
                ),
                SizedBox(height: 12.h),
                _buildFaqItem(
                  "How do I delete my account?",
                  "To delete your account, visit Security > Delete Account and provide your password for confirmation.",
                ),
                SizedBox(height: 12.h),
                _buildFaqItem(
                  "Where can I find the latest updates on app features?",
                  "Feature updates are announced in our notification center and the 'Latest News' section in settings.",
                ),
              ],
            ),
          ),
        ],
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
            "Support Center",
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

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
          iconColor: Get.theme.iconTheme.color,
          collapsedIconColor: Get.theme.iconTheme.color,
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          children: [
            Text(
              answer,
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: Colors.grey.shade400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
