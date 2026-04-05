import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

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
          'Change Email',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Current Email"),
            SizedBox(height: 8.h),
            _buildTextField(
              hint: "user002309@gmail.com",
              prefixIcon: Icons.email_outlined,
              enabled: false,
            ),
            SizedBox(height: 20.h),
            _buildLabel("Enter new Email"),
            SizedBox(height: 8.h),
            _buildTextField(
              hint: "user002309@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 20.h),
            _buildLabel("Password"),
            SizedBox(height: 8.h),
            _buildTextField(
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
                  color: const Color(0xFF4C080C),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C080C),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.manrope(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData prefixIcon,
    bool isPassword = false,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        enabled: enabled,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.manrope(
            fontSize: 13.sp,
            color: Colors.grey.shade400,
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.black87, size: 20.sp),
          suffixIcon: isPassword
              ? Icon(Icons.visibility_off_outlined,
                  color: Colors.black87, size: 20.sp)
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
