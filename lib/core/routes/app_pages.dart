import 'package:get/get.dart';

import '../../feature/auth/forgot_password/views/forgot_password_page.dart';
import '../../feature/auth/forgot_password/views/pages/reset_otp_page.dart';
import '../../feature/auth/forgot_password/views/pages/reset_password_page.dart';
import '../../feature/auth/login/views/login_page.dart';
import '../../feature/auth/registration/views/registration_page.dart';
import '../../feature/calendar/view/add_event_screen.dart';
import '../../feature/calendar/view/calendar_screen.dart';
import '../../feature/dashboard/view/dashboard_screen.dart';
import '../../feature/home/view/home_screen.dart';
import '../../feature/onboarding/view/onboarding_screen.dart';
import '../../feature/profile/view/change_password_screen.dart';
import '../../feature/profile/view/edit_profile_screen.dart';
import '../../feature/profile/view/privacy_policy_screen.dart';
import '../../feature/profile/view/profile_screen.dart';
import '../../feature/profile/view/settings_privacy_screen.dart';
import '../../feature/profile/view/terms_conditions_screen.dart';
import '../../feature/recovery/view/recovery_checkin_screen.dart';
import '../../feature/recovery/view/recovery_screen.dart';
import '../../feature/splash/view/splash_slides_screen.dart';
import '../../feature/training/view/add_training_screen.dart';
import '../../feature/training/view/training_screen.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashSlides;

  static final pages = [
    GetPage(name: Routes.splashSlides, page: () => SplashSlidesScreen()),
    GetPage(name: Routes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: Routes.login, page: () => const LoginPage()),
    GetPage(name: Routes.registration, page: () => const RegistrationPage()),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(name: Routes.resetPassword, page: () => const ResetPasswordPage()),
    GetPage(name: Routes.resetOtp, page: () => const ResetOtpPage()),
    GetPage(name: Routes.dashboard, page: () => const DashboardScreen()),
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.calendar, page: () => const CalendarScreen()),
    GetPage(name: Routes.addEvent, page: () => const AddEventScreen()),
    GetPage(name: Routes.recovery, page: () => const RecoveryScreen()),
    GetPage(
      name: Routes.recoveryCheckin,
      page: () => const RecoveryCheckinScreen(),
    ),
    GetPage(name: Routes.training, page: () => const TrainingScreen()),
    GetPage(name: Routes.addTraining, page: () => const AddTrainingScreen()),
    GetPage(name: Routes.profile, page: () => const ProfileScreen()),
    GetPage(name: Routes.editProfile, page: () => const EditProfileScreen()),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: Routes.termsConditions,
      page: () => const TermsConditionScreen(),
    ),
    GetPage(
      name: Routes.settingsPrivacy,
      page: () => const SettingsPrivacyScreen(),
    ),
  ];
}
