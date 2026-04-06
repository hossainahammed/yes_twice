import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../../../restaurant_dashboard/views/change_email_page.dart';
import 'change_password_page.dart';
import 'delete_account_page.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Security',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            _buildSecurityItem(
              context,
              Icons.email_outlined,
              'Change Email',
              'Update your account email address',
              () => Get.to(() => const ChangeEmailPage()),
            ),
            SizedBox(height: 16.h),
            _buildSecurityItem(
              context,
              Icons.lock_outline,
              'Change Password',
              'Reset your account password',
              () => Get.to(() => const ChangePasswordPage()),
            ),
            SizedBox(height: 16.h),
            _buildSecurityItem(
              context,
              Icons.delete_outline_rounded,
              'Delete Account',
              'Permanently remove your account',
              () => Get.to(() => const DeleteAccountPage()),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isDestructive ? Colors.red.withOpacity(0.3) : theme.dividerColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDestructive ? Colors.red.withOpacity(0.1) : AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22.sp,
                color: isDestructive ? Colors.red : AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: isDestructive ? Colors.red : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
