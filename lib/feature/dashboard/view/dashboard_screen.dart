import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';
import '../../home/view/home_screen.dart';
import '../../training/view/training_screen.dart';
import '../../calendar/view/calendar_screen.dart';
import '../../recovery/view/recovery_screen.dart';
import '../../profile/view/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the DashboardController
    final controller = Get.put(DashboardController(), permanent: true);

    final List<Widget> screens = [
      const HomeScreen(),
      const TrainingScreen(),
      const CalendarScreen(),
      const RecoveryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.activeTab.value,
            children: screens,
          )),
      bottomNavigationBar: Obx(() => ProfileBottomNavBar(activeIndex: controller.activeTab.value)),
    );
  }
}
