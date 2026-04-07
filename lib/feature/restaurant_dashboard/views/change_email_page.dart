import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

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
          'Change Email',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Current Email", textColor),
            SizedBox(height: 8.h),
            _buildTextField(
              context,
              hint: "user002309@gmail.com",
              prefixIcon: Icons.email_outlined,
              enabled: false,
            ),
            SizedBox(height: 20.h),
            _buildLabel("Enter new Email", textColor),
            SizedBox(height: 8.h),
            _buildTextField(
              context,
              hint: "user002309@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 20.h),
            _buildLabel("Password", textColor),
            SizedBox(height: 8.h),
            _buildTextField(
              context,
              hint: "Enter your password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFCA7373)
                      : const Color(0xFF4C080C),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                minimumSize: Size(double.infinity, 56.h),
              ),
              child: Text(
                "Update Email",
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color textColor) {
    return Text(
      text,
      style: GoogleFonts.manrope(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: textColor.withOpacity(0.8),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    required IconData prefixIcon,
    bool isPassword = false,
    bool enabled = true,
  }) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.dividerColor),
      ),
      child: TextField(
        enabled: enabled,
        obscureText: isPassword,
        style: GoogleFonts.manrope(
          fontSize: 13.sp,
          color: theme.textTheme.bodyLarge?.color,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.manrope(
            fontSize: 13.sp,
            color: Colors.grey.shade400,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
            size: 20.sp,
          ),
          suffixIcon: isPassword
              ? Icon(
                  Icons.visibility_off_outlined,
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
                  size: 20.sp,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }
}
