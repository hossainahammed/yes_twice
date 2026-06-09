import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();


  RxBool isDarkMode = Get.isDarkMode.obs;

  @override
  void onInit() {
    super.onInit();

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
