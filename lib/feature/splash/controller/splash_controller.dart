import 'package:yes_twice/core/offline_storage/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../onboarding/view/onboarding_screen.dart';
import '../../../feature/auth/login/views/login_page.dart';
import '../view/splash_slides_screen.dart';

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

      final splashSlidesDone =
          await SharedPreferencesHelper.isSplashSlidesCompleted();
      final onboardingDone =
          await SharedPreferencesHelper.isOnboardingCompleted();
      final token = await SharedPreferencesHelper.getToken();
      
      debugPrint('Splash Slides Completed: $splashSlidesDone');
      debugPrint('Onboarding Completed: $onboardingDone');
      debugPrint('Token: $token');

      if (!splashSlidesDone) {
        Get.offAll(() => SplashSlidesScreen());
      } else if (!onboardingDone) {
        Get.offAll(() => OnboardingScreen());
      } else if (token == null || token.isEmpty) {
        // No token — user is a guest
        Get.offAll(() => const LoginPage());
      } else {
        // Token present — user is logged in
        Get.offAll(() => const LoginPage());
      }
    } catch (e) {
      debugPrint('Error in splash logic: $e');
      Get.offAll(() => const LoginPage());
    }
  }
}
