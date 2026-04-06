import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class DeleteAccountConfirmPage extends StatelessWidget {
  const DeleteAccountConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

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
          'Delete Account',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
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
                'Are you sure you want to delete your account? Once you delete your account, all your data will be cleared permanently and cannot be undone.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: subTextColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),
              
              const CustomAuthField(
                label: 'Enter your password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                obscureText: true,
              ),
              
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () {}, // Submit delete
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9070B),
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'Delete Account',
                  style: GoogleFonts.manrope(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
