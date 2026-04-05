import 'package:bolaji277/core/constant/app_colors.dart';
import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'security_page.dart';
import 'contact_us_page.dart';
import 'support_center_page.dart';
import 'privacy_policy_page.dart';
import 'change_email_page.dart';
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
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          Icons.shield_outlined,
                          "Security",
                          onTap: () => Get.to(() => const SecurityPage()),
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.contact_phone_outlined,
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
                        _buildSettingsItem(
                          Icons.lock_outline,
                          "Privacy & Policy",
                          onTap: () => Get.to(() => const PrivacyPolicyPage()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Settings & Options",
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
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          Icons.person_outline,
                          "Update Personal Information",
                          subtitle: "Manage your profile details",
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.favorite_border,
                          "Saved",
                          subtitle: "Access your saved collections",
                        ),
                        _buildDivider(),
                        _buildSettingsItem(
                          Icons.email_outlined,
                          "Update Email",
                          subtitle:
                              "Change the email associated with your account",
                          onTap: () => Get.to(() => const ChangeEmailPage()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  GestureDetector(
                    onTap: () => _showLogoutDialog(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2EF),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: const Color(0xFFFF5252),
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Logout",
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFF5252),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Image.asset(ImagePath.logoutIcon),
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
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      minimumSize: Size(0, 50.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.offAll(() => const LoginPage()), // Do logout
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      minimumSize: Size(0, 50.h),
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 22.sp),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                color: Colors.grey.shade400,
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
        size: 20.sp,
      ),
      onTap: onTap,
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
