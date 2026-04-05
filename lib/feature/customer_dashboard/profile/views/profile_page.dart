import 'package:bolaji277/core/constant/image_path.dart';
import 'package:bolaji277/feature/auth/login/views/login_page.dart';
import 'package:bolaji277/feature/customer_dashboard/home/views/event_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
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
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'testemail@gmail.com',
                            style: GoogleFonts.manrope(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
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
                      // icon: Icon(
                      //   Icons.edit_outlined,
                      //   color: AppColors.primaryColor,
                      //   size: 24.sp,
                      // ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              Text('Activity', style: _sectionHeadingStyle()),
              SizedBox(height: 12.h),
              _buildMenuItem(Icons.bookmark_outline, 'Saved', () {}),
              _buildMenuItem(
                Icons.star_outline,
                'My reviews',
                () => Get.to(() => const MyReviewsPage()),
              ),

              SizedBox(height: 12.h),
              _buildMenuItem(
                Icons.event_available,
                'Active event',
                () => Get.to(() => const EventListPage()),
              ),

              SizedBox(height: 24.h),

              Text('General', style: _sectionHeadingStyle()),
              SizedBox(height: 12.h),
              _buildMenuItem(
                Icons.shield_outlined,
                'Security',
                () => Get.to(() => const SecurityPage()),
              ),
              _buildMenuItem(
                Icons.email_outlined,
                'Contact Us',
                () => Get.to(() => const ContactUsPage()),
              ),
              _buildMenuItem(
                Icons.help_outline,
                'Support Center',
                () => Get.to(() => const SupportCenterPage()),
              ),
              _buildMenuItem(
                Icons.lock_outline,
                'Privacy & Policy',
                () => Get.to(() => const PrivacyPolicyPage()),
              ),

              SizedBox(height: 8.h),
              _buildMenuItem(
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

  TextStyle _sectionHeadingStyle() {
    return GoogleFonts.manrope(
      fontSize: 14.sp,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? const Color(0xFFD9070B) : Colors.black87;
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
                color: isDestructive
                    ? color.withOpacity(0.1)
                    : Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isDestructive ? color : Colors.grey.shade700,
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
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 22.sp),
          ],
        ),
      ),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure you want to log out? You will need to login again to use the app later.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
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
