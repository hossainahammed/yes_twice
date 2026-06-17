import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  // Selected tab index
  var activeTab = 0.obs;

  // Streak days
  var streakDays = 5.obs;

  // Readiness score (updated via Recovery Screen)
  var readinessScore = 73.obs;

  // Reactive events list
  var events = <Map<String, dynamic>>[].obs;

  // Reactive recovery check-ins list
  var checkins = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Default mock events matching the screenshots
    events.value = [
      {
        'id': 'e1',
        'title': 'Best Effort',
        'time': '12:46',
        'date': DateTime(2026, 5, 19),
        'category': 'Practice',
        'duration': 60,
        'notes': 'How did the workout feel? Any observations?'
      }
    ];

    // Default mock check-ins matching the screenshots (three check-ins showing 48%)
    checkins.value = [
      {
        'id': 'c1',
        'date': DateTime(2026, 5, 7, 10, 8),
        'score': 48,
        'sleep': 9,
        'energy': 10,
        'stress': 10,
        'soreness': 10,
      },
      {
        'id': 'c2',
        'date': DateTime(2026, 5, 7, 10, 8),
        'score': 48,
        'sleep': 9,
        'energy': 10,
        'stress': 10,
        'soreness': 10,
      },
      {
        'id': 'c3',
        'date': DateTime(2026, 5, 7, 10, 8),
        'score': 48,
        'sleep': 9,
        'energy': 10,
        'stress': 10,
        'soreness': 10,
      },
    ];

    // Initialize readinessScore to matches the average of current check-ins (e.g., 48%)
    readinessScore.value = 48;
  }

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

  double get avgRecovery {
    if (checkins.isEmpty) return 0.0;
    int total = checkins.fold(0, (sum, c) => sum + (c['score'] as int));
    return total / checkins.length;
  }
}
