import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  // Selected tab index
  var activeTab = 0.obs;

  // Streak days
  var streakDays = 5.obs;

  // Readiness score (updated via Recovery Screen)
  var readinessScore = 73.obs;

  void changeTab(int index) {
    activeTab.value = index;
  }

  void incrementStreak() {
    streakDays.value++;
  }

  void updateReadiness(int score) {
    if (score >= 0 && score <= 100) {
      readinessScore.value = score;
    }
  }
}
