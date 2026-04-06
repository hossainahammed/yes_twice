import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
          'Edit Profile',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              _buildProfileImagePicker(context),
              SizedBox(height: 48.h),
              _buildInputField(
                context,
                label: 'Full Name',
                hint: 'Jack Michael',
                icon: Icons.person_outline_rounded,
              ),
              SizedBox(height: 20.h),
              _buildInputField(
                context,
                label: 'Email Address',
                hint: 'testemail@gmail.com',
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 20.h),
              _buildInputField(
                context,
                label: 'Phone Number',
                hint: '+80 8470500',
                icon: Icons.phone_android_outlined,
              ),
              SizedBox(height: 48.h),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 2),
          ),
          child: CircleAvatar(
            radius: 60.r,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(color: Colors.grey),
            prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.back(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: Size(double.infinity, 56.h),
        elevation: 8,
        shadowColor: AppColors.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Text(
        'Save Changes',
        style: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
