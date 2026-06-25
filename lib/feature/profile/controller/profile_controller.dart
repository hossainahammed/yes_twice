import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yes_twice/core/offline_storage/shared_pref.dart';
import '../../../feature/auth/login/views/login_page.dart';
import '../../training/controller/training_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  // Profile fields state
  var fullName = 'Alex Hossain'.obs;
  var email = 'alex000@gmail.com'.obs;
  var phone = '+971 50 123 4567'.obs;
  var avatarPath = 'assets/icons/profile.png'.obs;

  // Stats
  var trainingCount = 0.obs;
  var checkinsCount = 0.obs;
  var eventsCount = 0.obs;

  // Goals
  var goals = <String>['Improve Performance', 'Build Endurance'].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void saveChanges({
    required String name,
    required String email,
    required String phone,
    String? imagePath,
  }) {
    fullName.value = name;
    this.email.value = email;
    this.phone.value = phone;

    Get.snackbar(
      'Profile Updated',
      'Your profile details have been saved successfully.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
    );
  }

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'New passwords do not match.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }
    if (newPassword.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Password Changed',
      'Your password has been successfully updated.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
    );
  }

  void clearAllData() {
    trainingCount.value = 0;
    checkinsCount.value = 0;
    eventsCount.value = 0;
    goals.clear();

    if (Get.isRegistered<TrainingController>()) {
      Get.find<TrainingController>().clearWorkouts();
    }

    Get.snackbar(
      'Data Cleared',
      'All user cache and training metrics have been reset.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.withValues(alpha: 0.8),
      colorText: Colors.white,
    );
  }

  void logout() async {
    await SharedPreferencesHelper.clearToken();
    Get.offAll(() => const LoginPage());
  }
}
