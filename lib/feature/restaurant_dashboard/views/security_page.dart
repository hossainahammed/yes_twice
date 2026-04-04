import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_password_page.dart';
import 'delete_account_page.dart';
import 'restaurant_list_page.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Container(
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
                  _buildSecurityItem(
                    "Change Password",
                    () => Get.to(() => const ChangePasswordPage()),
                  ),
                  _buildDivider(),
                  _buildSecurityItem(
                    "Delete Restaurant",
                    () => Get.to(() => const RestaurantListPage(isForDelete: true)),
                  ),
                  _buildDivider(),
                  _buildSecurityItem(
                    "Delete Account",
                    () => Get.to(() => const DeleteAccountPage()),
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
            "Security",
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

  Widget _buildSecurityItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey.shade100,
      indent: 16.w,
      endIndent: 16.w,
    );
  }
}
