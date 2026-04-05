import 'package:bolaji277/core/constant/image_path.dart';
import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:bolaji277/feature/customer_dashboard/home/views/event_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../../../../core/theme/theme_controller.dart';
import 'edit_profile_page.dart';
import 'my_reviews_page.dart';
import 'security_page.dart';
import 'contact_us_page.dart';
import 'support_center_page.dart';
import 'privacy_policy_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardBg = Theme.of(context).cardColor;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    // Ensure ThemeController is available
    final themeController = Get.put(ThemeController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.15 : 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: const AssetImage(
                        'assets/images/profile.png',
                      ), // placeholder
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jack Michael',
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'testemail@gmail.com',
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: subTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(() => const EditProfilePage()),
                      icon: Image.asset(
                        ImagePath.profileEdit,
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              Text('Activity', style: _sectionHeadingStyle(textColor)),
              SizedBox(height: 12.h),
              _buildMenuItem(
                context,
                Icons.bookmark_outline,
                'Saved',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.star_outline,
                'My reviews',
                () => Get.to(() => const MyReviewsPage()),
              ),

              SizedBox(height: 12.h),
              _buildMenuItem(
                context,
                Icons.event_available,
                'Active event',
                () => Get.to(() => const EventListPage()),
              ),

              SizedBox(height: 24.h),

              Text('General', style: _sectionHeadingStyle(textColor)),
              SizedBox(height: 12.h),

              // ── Dark Mode Toggle ──
              _buildDarkModeToggle(context, themeController),

              _buildMenuItem(
                context,
                Icons.shield_outlined,
                'Security',
                () => Get.to(() => const SecurityPage()),
              ),
              _buildMenuItem(
                context,
                Icons.email_outlined,
                'Contact Us',
                () => Get.to(() => const ContactUsPage()),
              ),
              _buildMenuItem(
                context,
                Icons.help_outline,
                'Support Center',
                () => Get.to(() => const SupportCenterPage()),
              ),
              _buildMenuItem(
                context,
                Icons.lock_outline,
                'Privacy & Policy',
                () => Get.to(() => const PrivacyPolicyPage()),
              ),

              SizedBox(height: 8.h),
              _buildMenuItem(
                context,
                Icons.logout_outlined,
                'Logout',
                () => _showLogoutSheet(context),
                isDestructive: true,
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _sectionHeadingStyle(Color textColor) {
    return GoogleFonts.manrope(
      fontSize: 14.sp,
      fontWeight: FontWeight.w800,
      color: textColor,
    );
  }

  /// Dark / Light mode toggle row
  Widget _buildDarkModeToggle(
    BuildContext context,
    ThemeController themeController,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconBg = isDark ? Colors.grey.shade800 : Colors.grey.shade50;
    final iconColor = isDark ? Colors.amber.shade300 : Colors.grey.shade700;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: 20.sp,
              color: iconColor,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Dark Mode',
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          Obx(
            () => Switch.adaptive(
              value: themeController.isDarkMode.value,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (_) => themeController.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? Colors.white : Colors.black87;
    final color = isDestructive ? const Color(0xFFD9070B) : defaultColor;
    final iconBg = isDestructive
        ? color.withOpacity(0.1)
        : (isDark ? Colors.grey.shade800 : Colors.grey.shade50);
    final iconFg = isDestructive
        ? color
        : (isDark ? Colors.grey.shade300 : Colors.grey.shade700);
    final chevronColor = isDark ? Colors.grey.shade600 : Colors.grey.shade400;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: iconFg,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: chevronColor, size: 22.sp),
          ],
        ),
      ),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? const Color(0xFF232323) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final bodyColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ImagePath.logoutIcon, height: 70.h, fit: BoxFit.cover),
            SizedBox(height: 16.h),
            Text(
              'LOGOUT',
              style: GoogleFonts.manrope(
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: titleColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure you want to log out? You will need to login again to use the app later.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: bodyColor,
              ),
            ),
            SizedBox(height: 30.h),
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
}
