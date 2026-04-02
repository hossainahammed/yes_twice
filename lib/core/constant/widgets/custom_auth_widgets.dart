import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18.sp,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class CustomAuthField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final bool? obscureText;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController? controller;

  const CustomAuthField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText,
    this.onSuffixIconPressed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          style: GoogleFonts.manrope(fontSize: 14.sp, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Icon(
                prefixIcon,
                color: Colors.black87,
                size: 22.sp,
              ),
            ),
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: onSuffixIconPressed,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Icon(
                        (obscureText ?? true)
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black87,
                        size: 22.sp,
                      ),
                    ),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.text,
    this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              Image.asset(iconPath!, height: 24.h)
            else
              Image.network(
                "https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png",
                width: 22.w,
                height: 22.w,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.g_mobiledata,
                  color: Colors.blue,
                  size: 28.sp,
                ),
              ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
