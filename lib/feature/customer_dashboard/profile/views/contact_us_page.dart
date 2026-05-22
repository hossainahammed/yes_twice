import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
          'Contact Us',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We would love to hear from you! Please fill out the form below and we will get back to you as soon as possible.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 32.h),
              _buildContactField(
                context,
                label: 'Name',
                hint: 'Type your full name',
                icon: Icons.person_outline_rounded,
              ),
              SizedBox(height: 20.h),
              _buildContactField(
                context,
                label: 'Email Address',
                hint: 'Type your email address',
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 20.h),
              // --- Added Title Section ---
              _buildContactField(
                context,
                label: 'Subject / Title',
                hint: 'Type the subject of your message',
                icon: Icons.title_rounded,
              ),
              SizedBox(height: 20.h),
              // ---------------------------
              _buildMessageBox(context),
              SizedBox(height: 48.h),
              _buildSendButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactField(
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
            hintStyle: GoogleFonts.manrope(color: Colors.grey, fontSize: 14.sp),
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
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBox(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Message',
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          maxLines: 5,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: 'Type your message here...',
            hintStyle: GoogleFonts.manrope(color: Colors.grey, fontSize: 14.sp),
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
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
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
        'Send Message',
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
