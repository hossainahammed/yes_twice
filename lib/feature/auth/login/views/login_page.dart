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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedTab = 0; // 0 = User, 1 = Restaurant

  @override
  Widget build(BuildContext context) {
    final LoginPageController controller = Get.put(LoginPageController());
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : AppColors.textColor;
    final Color subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade500;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              /// ── Header ──────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: GoogleFonts.manrope(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 6.h),
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
              SizedBox(height: 24.h),

              /// ── User / Restaurant Toggle Tab ─────────────────────────
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    _buildTab(label: 'User', index: 0, isDark: isDark),
                    _buildTab(label: 'Restaurant', index: 1, isDark: isDark),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              /// ── Email Field ──────────────────────────────────────────
              CustomAuthField(
                label: 'Email Address',
                hint: 'Enter Email',
                prefixIcon: Icons.mail_outline_rounded,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 18.h),

              /// ── Password Field ───────────────────────────────────────
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

              /// ── Forgot Password ──────────────────────────────────────
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => ForgotPasswordPage()),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              /// ── Login Button ─────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedTab == 0) {
                      Get.offAll(() => const CustomerDashboard());
                    } else {
                      Get.offAll(() => RestaurantDashboardPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.manrope(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// ── OR Divider ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'OR',
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                ],
              ),
              SizedBox(height: 20.h),

              /// ── Continue with Google ─────────────────────────────────
              SocialLoginButton(text: 'Continue with Google', onTap: () {}),
              SizedBox(height: 28.h),

              /// ── Sign Up Footer ───────────────────────────────────────
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab({required String label, required int index, required bool isDark}) {
    final bool isActive = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(26.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            ),
          ),
        ),
      ),
    );
  }
}
