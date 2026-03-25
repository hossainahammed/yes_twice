import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_colors.dart';
import '../controller/onboarding_controller.dart';
import 'onboarding_page1.dart';
import 'onboarding_page2.dart';
import 'onboarding_page3.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// ─── Progress bar ───────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
              child: Obx(() => _ProgressBar(
                    total: controller.totalPages,
                    current: controller.currentPage.value,
                  )),
            ),

            /// ─── Page content ───────────────────────────────────────
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.changePage,
                physics: const BouncingScrollPhysics(),
                children: [
                  OnboardingPage1(
                    onNext: controller.nextPage,
                    onSkip: controller.skip,
                  ),
                  OnboardingPage2(
                    onNext: controller.nextPage,
                    onSkip: controller.skip,
                  ),
                  OnboardingPage3(
                    onNext: controller.nextPage,
                    onSkip: controller.skip,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int total;
  final int current;

  const _ProgressBar({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4.h,
            margin: EdgeInsets.only(right: i < total - 1 ? 8.w : 0),
            decoration: BoxDecoration(
              color: i <= current
                  ? AppColors.primaryColor
                  : const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
