import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../../../customer_dashboard/dashboard/dashboard.dart';
import '../../forgot_password/views/forgot_password_page.dart';
import '../../registration/views/registration_page.dart';
import '../controllers/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginPageController controller = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              const CustomBackButton(),
              SizedBox(height: 30.h),

              /// Header Title
              Center(
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: GoogleFonts.manrope(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to continue using the app.',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.h),

              /// Form Fields
              CustomAuthField(
                label: 'Email Address',
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                controller: controller.emailController,
              ),
              SizedBox(height: 20.h),

              Obx(
                () => CustomAuthField(
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: controller.isPasswordHidden.value,
                  onSuffixIconPressed: () {
                    controller.isPasswordHidden.value =
                        !controller.isPasswordHidden.value;
                  },
                  controller: controller.passwordController,
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => ForgotPasswordPage()),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              /// Login Button
              ElevatedButton(
                onPressed: () => Get.to(() => CustomerDashboard()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: 24.h),
              Center(
                child: Text(
                  'OR',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              /// Social Login
              SocialLoginButton(text: 'Continue with Google', onTap: () {}),
              SizedBox(height: 24.h),

              /// Claim Button
              ElevatedButton(
                onPressed: () {}, // => Get.to(() => ClaimPage()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'Claim your restaurant',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              /// Footer
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account? ",
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: GoogleFonts.manrope(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => RegistrationPage()),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
