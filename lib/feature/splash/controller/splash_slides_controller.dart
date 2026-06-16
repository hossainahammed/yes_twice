import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yes_twice/core/offline_storage/shared_pref.dart';
import '../../onboarding/view/onboarding_screen.dart';

class SplashSlidesController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final int totalPages = 3;

  void changePage(int index) {
    currentPage.value = index;
  }

  void nextPage() async {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await SharedPreferencesHelper.setSplashSlidesCompleted();
      Get.offAll(() => OnboardingScreen());
    }
  }

  void skip() async {
    await SharedPreferencesHelper.setSplashSlidesCompleted();
    Get.offAll(() => OnboardingScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
