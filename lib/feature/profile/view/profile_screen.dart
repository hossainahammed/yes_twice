import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import '../controller/profile_controller.dart';
import 'settings_privacy_screen.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/view/dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.8),
            radius: 1.5,
            colors: [
              Color(0xFF2B1416),
              Color(0xFF080808),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: GoogleFonts.lora(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => const SettingsPrivacyScreen()),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Profile Avatar Section
                Obx(() => Column(
                      children: [
                        Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              controller.avatarPath.value,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.account_circle,
                                  size: 80,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller.fullName.value,
                          style: GoogleFonts.lora(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.email.value,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFFB3B5BA),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Football',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    )),

                const SizedBox(height: 28),

                /// Stat Cards Row (3 cards)
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            icon: Image.asset(
                              'assets/icons/training_pulse.png',
                              width: 24,
                              height: 24,
                            ),
                            //  icon: Icons.bolt,
                            //
                            // iconColor: const Color(0xFF4CB5FF),
                            value: '${controller.trainingCount.value}',
                            label: 'Training',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            // icon: Icons.favorite,
                            // iconColor: const Color(0xFFFF4C4C),
                            icon: Image.asset('assets/icons/check-Ins.png',
                              width: 24,
                              height: 24,
                            ),
                            value: '${controller.checkinsCount.value}',
                            label: 'Check-ins',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            icon: Image.asset('assets/icons/event_icon.png',
                            width: 24,
                            height: 24,
                            ),
                            // icon: Icons.show_chart,
                            // iconColor: const Color(0xFFB54CFF),
                            value: '${controller.eventsCount.value}',
                            label: 'Events',
                          ),
                        ),
                      ],
                    )),

                const SizedBox(height: 24),

                /// Your Goals Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Goals',
                        style: GoogleFonts.lora(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        if (controller.goals.isEmpty) {
                          return Text(
                            'No goals selected. Edit them in onboarding.',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          );
                        }
                        return Column(
                          children: controller.goals.map((goal) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B2A4A),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4CB5FF),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    goal,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Data Management Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Data Management',
                        style: GoogleFonts.lora(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => controller.clearAllData(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                           // color: Colors.black.withValues(alpha: 0.35),
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFFF4C4C).withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                               // color: Color(0xFFFF4C4C),
                                color:AppColors.whiteColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Clear All Data',
                                style: GoogleFonts.poppins(
                                 // color: const Color(0xFFFF4C4C),
                                  color:AppColors.whiteColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Logout Button
                OutlinedButton(
                  onPressed: () => controller.logout(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF4C4C)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Color(0xFFFF4C4C), size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFF4C4C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
   // required IconData icon,
   // required Color iconColor,
    required Widget icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          //Icon(icon, color: iconColor, size: 24),
          icon,
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFFB3B5BA),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable shared bottom navigation bar widget
class ProfileBottomNavBar extends StatelessWidget {
  final int activeIndex;
  const ProfileBottomNavBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'label': 'Home', 'icon': 'assets/icons/home.png'},
      {'label': 'Training', 'icon': 'assets/icons/training.png'},
      {'label': 'Calendar', 'icon': 'assets/icons/calender.png'},
      {'label': 'Recovery', 'icon': 'assets/icons/recovery.png'},
      {'label': 'Profile', 'icon': 'assets/icons/profile.png'},
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF080808),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabs.length, (index) {
            final isActive = index == activeIndex;
            final item = tabs[index];
            return GestureDetector(
              onTap: () {
                final dashboardController = Get.put(DashboardController());
                dashboardController.changeTab(index);
                if (Navigator.of(context).canPop()) {
                  Get.offAll(() => const DashboardScreen());
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        item['icon']!,
                        width: 20,
                        height: 20,
                        color: isActive ? Colors.white : Colors.grey.shade600,
                        errorBuilder: (context, error, stackTrace) {
                          // Safe fallback icon
                          return Icon(
                            index == 0
                                ? Icons.home_outlined
                                : index == 1
                                    ? Icons.flash_on
                                    : index == 2
                                        ? Icons.calendar_today_outlined
                                        : index == 3
                                            ? Icons.favorite_border
                                            : Icons.person_outline,
                            color: isActive ? Colors.white : Colors.grey.shade600,
                            size: 20,
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['label']!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
