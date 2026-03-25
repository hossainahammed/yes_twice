import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../controllers/registration_page_controller.dart';
import 'pages/registration_otp_page.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final RegistrationPageController controller = Get.put(RegistrationPageController());

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
              const CustomBackButton(),
              SizedBox(height: 30.h),

              /// Header Title
              Center(
                child: Column(
                  children: [
                    Text(
                      'Create New Account',
                      style: GoogleFonts.manrope(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Join PLTFUL and start your food journey.',
                      style: GoogleFonts.manrope(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              /// Form Fields
              CustomAuthField(
                label: 'First name',
                hint: 'Enter First Name',
                prefixIcon: Icons.person_outline_rounded,
                controller: controller.firstNameController,
              ),
              SizedBox(height: 20.h),
              
              CustomAuthField(
                label: 'Last name',
                hint: 'Enter Last Name',
                prefixIcon: Icons.person_outline_rounded,
                controller: controller.lastNameController,
              ),
              SizedBox(height: 20.h),

              CustomAuthField(
                label: 'Email Address',
                hint: 'Enter Email Address',
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
              
              SizedBox(height: 24.h),

              /// Terms and Conditions
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.agreedToTerms.value =
                            !controller.agreedToTerms.value;
                      },
                      child: Container(
                        width: 22.w,
                        height: 22.w,
                        margin: EdgeInsets.only(top: 2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.agreedToTerms.value 
                                ? AppColors.primaryColor 
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                          color: controller.agreedToTerms.value
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        ),
                        child: controller.agreedToTerms.value
                            ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "By continuing, you agree to the ",
                        style: GoogleFonts.manrope(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const TextSpan(text: " and our "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16.h),
              
              /// Marketing checkbox
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, size: 12.sp, color: Colors.white),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Yes, I Sign me up to receive emails from PLTFUL",
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 48.h),

              /// Create Account Button
              ElevatedButton(
                onPressed: () {
                   Get.to(() => const RegistrationOtpPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                ),
                child: Text(
                  'Create Account',
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

