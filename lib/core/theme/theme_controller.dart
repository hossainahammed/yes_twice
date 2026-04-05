import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  // Observable property to check if dark mode is active
  RxBool isDarkMode = Get.isDarkMode.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize based on current system theme if not already set
    isDarkMode.value = Get.isDarkMode;
  }

  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      isDarkMode.value = true;
    }
  }
}
