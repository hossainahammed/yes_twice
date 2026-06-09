import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../../../../../core/constant/widgets/success_dialog.dart';
import '../../../login/views/login_page.dart';
import '../../controllers/reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              SizedBox(height: 30.h),

              /// Header Title
              Text(
                'Enter New Password',
                style: GoogleFonts.manrope(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your new password must be different from previously used password.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 48.h),

              /// Form Fields
              Obx(
                () => CustomAuthField(
                  label: 'Enter new password',
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: controller.isPasswordHidden.value,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  onSuffixIconPressed: () {
                    controller.isPasswordHidden.value =
                        !controller.isPasswordHidden.value;
                  },
                  controller: controller.passwordController,
                ),
              ),
              SizedBox(height: 20.h),

              Obx(
                () => CustomAuthField(
                  label: 'Confirm password',
                  hint: 'Enter Confirm Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  onSuffixIconPressed: () {
                    controller.isConfirmPasswordHidden.value =
                        !controller.isConfirmPasswordHidden.value;
                  },
                  controller: controller.confirmPasswordController,
                ),
              ),

              SizedBox(
                height: 120.h,
              ),
              /// Reset Password Button
              ElevatedButton(
                onPressed: () => SuccessDialog.show(
                  title: "Password reset success!",
                  subtitle: "Your password is successfully reset",
                  context: context,
                  onPressed: () => Get.to(() => LoginPage()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'Reset password',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
