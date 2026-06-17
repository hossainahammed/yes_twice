import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/workout_model.dart';
import '../../../feature/profile/controller/profile_controller.dart';

class TrainingController extends GetxController {
  var workouts = <WorkoutModel>[].obs;
  var searchQuery = ''.obs;
  var filterOption = 'Daily'.obs; // Daily, Weekly, Monthly

  @override
  void onInit() {
    super.onInit();
    loadWorkouts();
  }

  // Filtered workouts based on search query and time filter
  List<WorkoutModel> get filteredWorkouts {
    List<WorkoutModel> list = workouts;

    // Apply search query
    if (searchQuery.value.trim().isNotEmpty) {
      list =
          list
              .where(
                (w) => w.type.toLowerCase().contains(
                  searchQuery.value.toLowerCase().trim(),
                ),
              )
              .toList();
    }

    // Apply time filter (Daily, Weekly, Monthly)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (filterOption.value == 'Daily') {
      list =
          list.where((w) {
            final wDate = DateTime(w.date.year, w.date.month, w.date.day);
            return wDate.isAtSameMomentAs(today);
          }).toList();
    } else if (filterOption.value == 'Weekly') {
      final sevenDaysAgo = today.subtract(const Duration(days: 7));
      list =
          list
              .where(
                (w) =>
                    w.date.isAfter(sevenDaysAgo) ||
                    w.date.isAtSameMomentAs(sevenDaysAgo),
              )
              .toList();
    } else if (filterOption.value == 'Monthly') {
      final thirtyDaysAgo = today.subtract(const Duration(days: 30));
      list =
          list
              .where(
                (w) =>
                    w.date.isAfter(thirtyDaysAgo) ||
                    w.date.isAtSameMomentAs(thirtyDaysAgo),
              )
              .toList();
    }

    return list;
  }

  // Averages
  int get avgWorkload {
    if (workouts.isEmpty) return 0;
    int total = workouts.fold(0, (sum, w) => sum + w.workload);
    return (total / workouts.length).round();
  }

  int get avgRpe {
    if (workouts.isEmpty) return 0;
    double total = workouts.fold(0.0, (sum, w) => sum + w.rpe.toDouble());
    return (total / workouts.length).round();
  }

  // Weekly Load sum (e.g. past 7 days, or sum of all current)
  int get weeklyLoad {
    if (workouts.isEmpty) return 0;
    // For visual consistency, let's sum workouts of the last 7 days.
    // If we want it to match the screenshot's '280' or be dynamic, let's calculate it dynamically.
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    // Fallback: If no workouts in last 7 days, return total workload of current list
    final recentWorkouts =
        workouts.where((w) => w.date.isAfter(sevenDaysAgo)).toList();
    if (recentWorkouts.isEmpty) {
      return workouts.fold(0, (sum, w) => sum + w.workload);
    }
    return recentWorkouts.fold(0, (sum, w) => sum + w.workload);
  }

  // Add a workout
  void addWorkout(WorkoutModel workout) {
    workouts.insert(0, workout);
    saveWorkouts();
    syncWithProfile();
  }

  // Delete a workout
  void deleteWorkout(String id) {
    workouts.removeWhere((w) => w.id == id);
    saveWorkouts();
    syncWithProfile();
  }

  // Edit a workout
  void editWorkout(
    String id,
    String type,
    int duration,
    int rpe,
    DateTime date,
  ) {
    final index = workouts.indexWhere((w) => w.id == id);
    if (index != -1) {
      workouts[index] = WorkoutModel(
        id: id,
        type: type,
        duration: duration,
        rpe: rpe,
        date: date,
      );
      saveWorkouts();
      syncWithProfile();
    }
  }

  // Clear all workouts
  void clearWorkouts() {
    workouts.clear();
    saveWorkouts();
    syncWithProfile();
  }

  // Sync with profile stats
  void syncWithProfile() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().trainingCount.value = workouts.length;
    }
  }

  // Load from SharedPreferences
  Future<void> loadWorkouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? workoutsJson = prefs.getStringList('logged_workouts');
      if (workoutsJson != null) {
        workouts.value =
            workoutsJson
                .map((jsonStr) => WorkoutModel.fromJson(jsonStr))
                .toList();
      } else {
        // Pre-populate with default data matching the mockup screens
        final mockDate = DateTime(2026, 5, 5);
        workouts.value = [
          WorkoutModel(
            id: '1',
            type: 'Swimming',
            duration: 60,
            rpe: 8,
            date: mockDate,
          ),
          WorkoutModel(
            id: '2',
            type: 'Running',
            duration: 60,
            rpe: 8,
            date: mockDate,
          ),
          WorkoutModel(
            id: '3',
            type: 'Swimming',
            duration: 60,
            rpe: 8,
            date: mockDate,
          ),
          WorkoutModel(
            id: '4',
            type: 'Gym',
            duration: 60,
            rpe: 8,
            date: mockDate,
          ),
        ];
        await saveWorkouts();
      }
      syncWithProfile();
    } catch (e) {
      print('Error loading workouts: $e');
    }
  }

  // Save to SharedPreferences
  Future<void> saveWorkouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> workoutsJson =
          workouts.map((w) => w.toJson()).toList();
      await prefs.setStringList('logged_workouts', workoutsJson);
    } catch (e) {
      print('Error saving workouts: $e');
    }
  }
}
