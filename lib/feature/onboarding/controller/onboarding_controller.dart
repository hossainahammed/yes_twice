import 'package:bolaji277/feature/customer_dashboard/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bolaji277/core/offline_storage/shared_pref.dart';
import 'package:bolaji277/core/service/auth_service.dart';

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
      AuthService.to.setGuestMode(true); // ✅ enter as guest
      Get.offAll(() => const CustomerDashboard()); 
    }
  }

  void skip() async {
    await SharedPreferencesHelper.setOnboardingCompleted();
    AuthService.to.setGuestMode(true); // ✅ enter as guest
    Get.offAll(() => const CustomerDashboard());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
