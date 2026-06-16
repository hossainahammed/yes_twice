import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yes_twice/core/offline_storage/shared_pref.dart';
import '../../../feature/auth/login/views/login_page.dart';

class OnboardingController extends GetxController {
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
      await SharedPreferencesHelper.setOnboardingCompleted();

      Get.offAll(() => const LoginPage());
    }
  }

  void skip() async {
    await SharedPreferencesHelper.setOnboardingCompleted();

    Get.offAll(() => const LoginPage());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
