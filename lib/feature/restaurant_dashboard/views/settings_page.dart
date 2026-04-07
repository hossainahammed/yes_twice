import 'package:bolaji277/core/constant/app_colors.dart';
import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:bolaji277/feature/restaurant_dashboard/views/add_account_page.dart';
import 'package:bolaji277/feature/restaurant_dashboard/views/add_event_page.dart';
import 'package:bolaji277/feature/restaurant_dashboard/controllers/restaurant_dashboard_controller.dart';

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

import '../../../../core/theme/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    final isDark = themeController.isDarkMode.value;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Info",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          Icons.person_outline,
                          "My Profile",
                          context: context,
                          onTap: () {
                            final controller =
                                Get.find<RestaurantDashboardController>();
                            controller.changeNavIndex(5);
                          },
                        ),
                        // _buildDivider(),
                        _buildSettingsItem(
                          Icons.add_business_outlined,
                          "Add Restaurant",
                          context: context,
                          onTap: () => Get.to(() => const AddAccountPage()),
                        ),
                        //   _buildDivider(),
                        _buildSettingsItem(
                          Icons.event_outlined,
                          "Add Event",
                          onTap: () => Get.to(() => const AddEventPage()),
                          context: context,
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "General",
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => SwitchListTile(
                            title: Text(
                              themeController.isDarkMode.value
                                  ? "Dark Mode"
                                  : "Light Mode",
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    context.theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                            secondary: Icon(
                              themeController.isDarkMode.value
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: context.theme.iconTheme.color,
                              size: 22.sp,
                            ),
                            value: themeController.isDarkMode.value,
                            onChanged: (value) => themeController.toggleTheme(),
                            activeColor: themeController.isDarkMode.value
                                ? Colors.white
                                : AppColors.primaryColor,
                          ),
                        ),
                        //  _buildDivider(),
                        _buildSettingsItem(
                          Icons.shield_outlined,
                          "Security",
                          onTap: () => Get.to(() => const SecurityPage()),
                          context: context,
                        ),
                        //  _buildDivider(),
                        _buildSettingsItem(
                          Icons.contact_phone_outlined,
                          "Contact Us",
                          onTap: () => Get.to(() => const ContactUsPage()),
                          context: context,
                        ),
                        //  _buildDivider(),
                        _buildSettingsItem(
                          Icons.help_outline,
                          "Support Center",
                          onTap: () => Get.to(() => const SupportCenterPage()),
                          context: context,
                        ),
                        //  _buildDivider(),
                        _buildSettingsItem(
                          Icons.lock_outline,
                          "Privacy & Policy",
                          onTap: () => Get.to(() => const PrivacyPolicyPage()),
                          context: context,
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
                      color: context.theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          Icons.person_outline,
                          "Update Personal Information",
                          subtitle: "Manage your profile details",
                          context: context,
                        ),
                        // _buildDivider(),
                        _buildSettingsItem(
                          Icons.favorite_border,
                          "Saved",
                          subtitle: "Access your saved collections",
                          context: context,
                        ),
                        //    _buildDivider(),
                        _buildSettingsItem(
                          Icons.email_outlined,
                          "Update Email",
                          subtitle:
                              "Change the email associated with your account",
                          onTap: () => Get.to(() => const ChangeEmailPage()),
                          context: context,
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
                        color: isDark
                            ? const Color(0xFF381B1B)
                            : const Color(0xFFFFF2EF),
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

  Widget _buildHeader(BuildContext context) {
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
          GestureDetector(
            onTap: () => _showAccountSwitcherSheet(context),
            child: Container(
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
          ),
        ],
      ),
    );
  }

  void _showAccountSwitcherSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5);
    final cardBg = isDark ? const Color(0xFF2A2A2A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // ── Current account card ──
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Current restaurant row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage:
                            AssetImage(ImagePath.dashboardProfile),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "The Rustic Bistro",
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ),
                      // Checkmark badge
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 24.h,
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                  ),
                  // Add Another Account row
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.to(() => const AddAccountPage());
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20.sp,
                            color: isDark
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "Add Another Restaurant",
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Your Another Profile section ──
            Text(
              "Your Another Restaurant",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: subTextColor,
              ),
            ),
            SizedBox(height: 12.h),

            // Another profile card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage:
                        AssetImage(ImagePath.dashboardProfile),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "The Rustic Bistro",
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    String? subtitle,
    VoidCallback? onTap,
    BuildContext? context,
  }) {
    final theme = context?.theme ?? Get.theme;
    return ListTile(
      leading: Icon(icon, color: theme.iconTheme.color, size: 22.sp),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: theme.textTheme.bodyMedium?.color,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: theme.dividerColor,
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

