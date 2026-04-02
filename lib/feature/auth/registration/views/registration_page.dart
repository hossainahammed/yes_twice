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
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.06;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              SizedBox(height: 20.h),

              /// Header Title
              Center(
                child: Column(
                  children: [
                    Text(
                      'Create New Account',
                      style: GoogleFonts.manrope(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Get started and discover flavor at your fingertips!',
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

              /// User/Restaurant Toggle
              Obx(() => Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.isRestaurant.value = false,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: !controller.isRestaurant.value ? AppColors.primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'User',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: !controller.isRestaurant.value ? Colors.white : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.isRestaurant.value = true,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: controller.isRestaurant.value ? AppColors.primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Restaurant',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: controller.isRestaurant.value ? Colors.white : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(height: 35.h),

              /// Dynamic Form Fields
              Obx(() => Column(
                children: [
                  if (!controller.isRestaurant.value) ...[
                    CustomAuthField(
                      label: 'First name',
                      hint: 'Enter First Name',
                      prefixIcon: Icons.person_outline_rounded,
                      controller: controller.firstNameController,
                    ),
                    SizedBox(height: 25.h),
                    CustomAuthField(
                      label: 'Last name',
                      hint: 'Enter Last Name',
                      prefixIcon: Icons.person_outline_rounded,
                      controller: controller.lastNameController,
                    ),
                  ] else ...[
                    CustomAuthField(
                      label: 'Restaurant name',
                      hint: 'Enter Name',
                      prefixIcon: Icons.restaurant_outlined,
                      controller: controller.restaurantNameController,
                    ),
                    SizedBox(height: 25.h),
                    CustomAuthField(
                      label: 'Address',
                      hint: 'Enter Address',
                      prefixIcon: Icons.location_on_outlined,
                      controller: controller.addressController,
                    ),
                  ],
                  SizedBox(height: 25.h),
                  CustomAuthField(
                    label: 'Email Address',
                    hint: 'Enter Email Address',
                    prefixIcon: Icons.email_outlined,
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 25.h),
                  Obx(() => CustomAuthField(
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    obscureText: controller.isPasswordHidden.value,
                    onSuffixIconPressed: () {
                      controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
                    },
                    controller: controller.passwordController,
                  )),
                ],
              )),

              SizedBox(height: 30.h),

              /// Agreements
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "By continuing, you agree to PLTFUL ",
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.black,
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const TextSpan(text: " and acknowledge PLTFUL "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const TextSpan(text: "."),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() => GestureDetector(
                      onTap: () {
                        controller.agreedToTerms.value = !controller.agreedToTerms.value;
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 22.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                              color: controller.agreedToTerms.value ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(
                                color: controller.agreedToTerms.value ? AppColors.primaryColor : Colors.grey.shade400,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: controller.agreedToTerms.value
                                ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "Yes, Sign me up to receive e-mails from PLTFUL.",
                              style: GoogleFonts.manrope(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              SizedBox(height: 35.h),

              /// Create Account Button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const RegistrationOtpPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity, 58.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                ),
                child: Text(
                  'Create Account',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

