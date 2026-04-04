import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'security_page.dart';
import 'contact_us_page.dart';
import 'support_center_page.dart';
import 'privacy_policy_page.dart';
import '../../../../core/constant/image_path.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    "General",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          Icons.security_outlined,
                          "Security",
                          onTap: () => Get.to(() => const SecurityPage()),
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.email_outlined,
                          "Contact Us",
                          onTap: () => Get.to(() => const ContactUsPage()),
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.help_outline,
                          "Support Center",
                          onTap: () => Get.to(() => const SupportCenterPage()),
                        ),
                        _buildDivider(),
                        _buildSettingsItem(Icons.chat_bubble_outline, "FAQs"),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.lock_outline,
                          "Privacy & Policy",
                          onTap: () => Get.to(() => const PrivacyPolicyPage()),
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.logout_rounded,
                          "Logout",
                          isLogout: true,
                          onTap: () => _showLogoutDialog(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(ImagePath.logoutIcon),
                // child: Icon(
                //   Icons.report_problem_rounded,
                //   color: Colors.red,
                //   size: 32.sp,
                // ),
              ),
              SizedBox(height: 16.h),
              Text(
                "LOGOUT",
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Are you sure you want to log out? You will need to sign in again to access your account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.to(() => LoginPage()),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        "Logout",
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: const Color(0xFFFDE8E4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4C080C),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: AssetImage(ImagePath.dashboardProfile),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back ,",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Text(
                  "The Rustic Bistro",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.black87,
        size: 22.sp,
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : Colors.black87,
        ),
      ),
      trailing: isLogout
          ? null
          : Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20.sp),
      onTap:
          onTap ??
          () {
            if (isLogout) {
              // Add logout logic
            }
          },
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey.shade100,
      indent: 50.w,
      endIndent: 20.w,
    );
  }
}
