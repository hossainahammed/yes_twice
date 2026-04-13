import 'package:bolaji277/feature/restaurant_dashboard/views/restaurant_dashboard_page.dart';
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
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginPageController controller = Get.put(LoginPageController());
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkSurfaceColor : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (Navigator.of(context).canPop())
                    const CustomBackButton()
                  else
                    const SizedBox.shrink(),
                  Text(
                    'Login',
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 40), // Spacing for alignment
                ],
              ),
              SizedBox(height: 40.h),

              /// Header Title
              Center(
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: GoogleFonts.manrope(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Login to continue using the app.',
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              /// Role Selection Toggle
              Obx(
                () => Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedRole.value = 'user',
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedRole.value == 'user'
                                  ? AppColors.buttonColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'User',
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: controller.selectedRole.value == 'user'
                                    ? Colors.white
                                    : textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedRole.value = 'restaurant',
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedRole.value == 'restaurant'
                                  ? AppColors.buttonColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'Restaurant',
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: controller.selectedRole.value == 'restaurant'
                                    ? Colors.white
                                    : textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              /// Form Fields
              CustomAuthField(
                label: 'Email Address',
                hint: 'Enter Email',
                prefixIcon: Icons.email_outlined,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
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
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              /// Login Button
              ElevatedButton(
                onPressed: () {
                  if (controller.selectedRole.value == 'user') {
                    Get.offAll(() => const CustomerDashboard());
                  } else {
                    Get.offAll(() => RestaurantDashboardPage());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'OR',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              SizedBox(height: 20.h),

              /// Google Login Button
              SocialLoginButton(
                text: 'Continue with Google',
                onTap: () {
                  // TODO: Implement Google Sign In
                },
              ),

              SizedBox(height: 30.h),

              /// Footer
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account? ",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
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
                    ],
                  ),
                ),
      ),
    );
  }
}
