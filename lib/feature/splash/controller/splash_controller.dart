import 'package:bolaji277/core/offline_storage/shared_pref.dart';
import 'package:bolaji277/core/service/auth_service.dart';
import 'package:bolaji277/feature/customer_dashboard/dashboard/dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../onboarding/view/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _startSplash();
  }

  Future<void> _startSplash() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final onboardingDone =
          await SharedPreferencesHelper.isOnboardingCompleted();
      final token = await SharedPreferencesHelper.getToken();
      debugPrint('Onboarding Completed: $onboardingDone');
      debugPrint('Token: $token');

      if (!onboardingDone) {
        Get.offAll(() => OnboardingScreen());
      } else if (token == null || token.isEmpty) {
        // No token — user is a guest
        AuthService.to.setGuestMode(true); // ✅
        Get.offAll(() => const CustomerDashboard());
      } else {
        // Token present — user is logged in
        AuthService.to.setLoggedIn(); // ✅
        Get.offAll(() => const CustomerDashboard());
      }
    } catch (e) {
      debugPrint('Error in splash logic: $e');
      AuthService.to.setGuestMode(true); // ✅ safe fallback
      Get.offAll(() => const CustomerDashboard());
    }
  }
}
