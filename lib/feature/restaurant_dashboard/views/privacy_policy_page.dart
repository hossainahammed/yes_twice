import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Terms & Conditions",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Get.theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Last updated: [Date]",
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                   _buildPolicySection(
                    "1. Acceptance of Terms",
                    "By creating an account or using our App, you confirm that you accept these Terms and Conditions and agree to follow all applicable laws and regulations.",
                  ),
                   _buildPolicySection(
                    "2. User Account",
                    "To access certain features, you may need to create an account. You agree to: Provide accurate and complete information. Keep your login details secure. Be responsible for all activities under your account. Notify us immediately if you notice unauthorized use of your account. We reserve the right to suspend or terminate accounts that violate these Terms.",
                  ),
                   _buildPolicySection(
                    "3. User Responsibilities",
                    "When using the App, you agree NOT to: Provide false information. Upload harmful, illegal, or offensive content. Attempt to hack, damage, or disrupt the App. Use the App for fraudulent purposes. Copy or misuse content without permission.",
                  ),
                   _buildPolicySection(
                    "4. Restaurant / Business Listings (if applicable)",
                    "If the App allows restaurant or business listings: Users must provide accurate business information. The business owner is responsible for menu, pricing, and details. We are not responsible for incorrect information provided by users or business owners.",
                  ),
                  _buildPolicySection(
                    "5. Content",
                    "Users may upload text, images, reviews, or other content. By uploading content, you confirm that: The content belongs to you or you have permission to use it. The content does not violate any law. We have the right to display the content within the App. We may remove any content that violates our policy.",
                  ),
                  _buildPolicySection(
                    "6. Payments (if applicable)",
                    "If the App includes paid services: All payments must be completed through approved payment methods. Prices may change at any time. Refund policy will follow our refund guidelines.",
                  ),
                   _buildPolicySection(
                    "7. Privacy",
                    "Your privacy is important to us. Please review our Privacy Policy to understand how we collect and use your information.",
                  ),
                  _buildPolicySection(
                    "8. Account Termination",
                    "We may suspend or terminate your account if: You violate these Terms. You misuse the App. Required by law. Users may also delete their account at any time through the App settings.",
                  ),
                   _buildPolicySection(
                    "9. Limitation of Liability",
                    "We are not responsible for: Loss of data. Business loss. Indirect damages. Issues caused by third-party services. The App is provided \"as is\" without guarantees of uninterrupted service.",
                  ),
                ],
              ),
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
            "Privacy & Policy",
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

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
