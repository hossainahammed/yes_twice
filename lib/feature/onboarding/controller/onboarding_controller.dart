import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yes_twice/core/offline_storage/shared_pref.dart';
import 'package:yes_twice/feature/dashboard/view/dashboard_screen.dart';
//import '../../../feature/auth/login/views/login_page.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final int totalPages = 4;

  // Personal Info Form Controllers
  final ageController = TextEditingController(text: '24');
  final heightController = TextEditingController(text: '172');
  final weightController = TextEditingController(text: '80');

  // Unit selections
  var isCm = true.obs;
  var isKg = true.obs;

  // Selected Sport (grid selection, single choice)
  var selectedSport = 'Football'.obs;

  // Selected Goals (list selection, multiple choices)
  var selectedGoals = <String>['Improve Performance'].obs;

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
      //Get.offAll(() => const LoginPage());
      Get.offAll(() => const DashboardScreen());
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() async {
    await SharedPreferencesHelper.setOnboardingCompleted();
    Get.offAll(() => const DashboardScreen());
  }

  void toggleHeightUnit(bool value) {
    isCm.value = value;
  }

  void toggleWeightUnit(bool value) {
    isKg.value = value;
  }

  void selectSport(String sport) {
    selectedSport.value = sport;
  }

  void toggleGoal(String goal) {
    if (selectedGoals.contains(goal)) {
      if (selectedGoals.length > 1) {
        selectedGoals.remove(goal);
      } else {
        Get.snackbar(
          'Notice',
          'Please select at least one goal',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black54,
          colorText: Colors.white,
        );
      }
    } else {
      selectedGoals.add(goal);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.onClose();
  }
}
