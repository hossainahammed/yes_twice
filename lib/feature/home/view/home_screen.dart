import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import '../../profile/controller/profile_controller.dart';
import '../../training/controller/training_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../training/model/workout_model.dart';
import '../widgets/custom_painters.dart';
import '../../training/view/add_training_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controllers are registered
    final profileController = Get.put(ProfileController());
    final trainingController = Get.put(TrainingController());
    final dashboardController = Get.put(DashboardController());

    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

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
              Color(0xFF2B1416), // Dark burgundy glow
              Color(0xFF080808), // Near black
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Bar Welcome Row
                Row(
                  children: [
                    // Avatar Image
                    Obx(
                      () => Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            profileController.avatarPath.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.account_circle,
                                size: 40,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Greeting & Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            'Welcome ${profileController.fullName.value.split(" ").first}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dateStr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFB3B5BA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                /// Streak Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7F7F).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/icons/Current_Streak.png',
                          width: 24,
                          height: 24,
                          errorBuilder:
                              (c, e, s) => const Icon(
                                Icons.local_fire_department,
                                color: Color(0xFFFF7F7F),
                                size: 24,
                              ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Streak',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB3B5BA),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(
                              () => Text(
                                '${dashboardController.streakDays.value} Days',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Keep it going! You're on fire 🔥",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFB3B5BA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// Weekly Load & Readiness Info Cards Row
                Row(
                  children: [
                    // Weekly Load
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/icons/weeklyLoad_Progress.png',
                                width: 18,
                                height: 18,
                                errorBuilder:
                                    (c, e, s) => const Icon(
                                      Icons.trending_up,
                                      color: Color(0xFF3B82F6),
                                      size: 18,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weekly Load',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFB3B5BA),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Obx(
                                    () => Text(
                                      '${trainingController.weeklyLoad}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Readiness
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/icons/love.png',
                                width: 18,
                                height: 18,
                                errorBuilder:
                                    (c, e, s) => const Icon(
                                      Icons.favorite,
                                      color: Color(0xFF10B981),
                                      size: 18,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Readiness',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFB3B5BA),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Obx(
                                    () => Text(
                                      '${dashboardController.readinessScore.value}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(
                                          0xFF60A5FA,
                                        ), // Light Blue tint
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// Today's Readiness Gauge Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Readiness",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/like.png',
                            width: 16,
                            height: 16,
                            errorBuilder:
                                (c, e, s) => const Icon(
                                  Icons.thumb_up,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          // Gauge
                          Obx(() {
                            final score =
                                dashboardController.readinessScore.value;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 76,
                                  height: 76,
                                  child: CustomPaint(
                                    painter: ReadinessGaugePainter(
                                      score: score,
                                    ),
                                  ),
                                ),
                                Text(
                                  '$score',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(width: 20),
                          // Assessment
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  final score =
                                      dashboardController.readinessScore.value;
                                  String status = 'Moderate';
                                  if (score > 80)
                                    status = 'Excellent';
                                  else if (score > 60)
                                    status = 'Good';
                                  else if (score > 40)
                                    status = 'Moderate';
                                  else
                                    status = 'Poor';

                                  return Text(
                                    status,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(
                                        0xFF3B82F6,
                                      ), // Blue title text
                                    ),
                                  );
                                }),
                                const SizedBox(height: 4),
                                Text(
                                  'Great job logging your recovery!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFB3B5BA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// Weekly Training Load & Recovery Line Chart Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Training Load & Recovery',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Custom Line Chart
                      Obx(() {
                        // Generate weekly loads for painter from actual workouts
                        List<double> points = List.filled(7, 0.0);
                        // Default base shape for illustration if no workouts logged
                        final defaultLoads = [
                          300.0,
                          480.0,
                          320.0,
                          520.0,
                          420.0,
                          800.0,
                          280.0,
                        ];

                        if (trainingController.workouts.isEmpty) {
                          points = defaultLoads;
                        } else {
                          // Try to calculate daily sum for the last 7 days
                          final now = DateTime.now();
                          for (int i = 0; i < 7; i++) {
                            final dateToCheck = now.subtract(
                              Duration(days: 6 - i),
                            );
                            final dailyWorkouts =
                                trainingController.workouts.where((w) {
                                  return w.date.year == dateToCheck.year &&
                                      w.date.month == dateToCheck.month &&
                                      w.date.day == dateToCheck.day;
                                }).toList();

                            double sum = dailyWorkouts.fold(
                              0.0,
                              (s, w) => s + w.workload,
                            );
                            points[i] =
                                sum > 0
                                    ? sum
                                    : defaultLoads[i]; // Fallback to mockup curves if no logs
                            if (points[i] > 1200)
                              points[i] = 1200; // Cap visual scale
                          }
                        }

                        return SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: CustomPaint(
                            painter: WeeklyLoadChartPainter(dataPoints: points),
                          ),
                        );
                      }),
                      const SizedBox(height: 14),
                      // Chart Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF5A5A),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Load',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFFB3B5BA),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Recovery %',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFFB3B5BA),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Recent Training Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Training',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap:
                          () => dashboardController.changeTab(
                            1,
                          ), // Navigates to Training Log
                      child: Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFB3B5BA),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Recent Training items
                Obx(() {
                  final recentWorkouts =
                      trainingController.workouts.take(2).toList();
                  if (recentWorkouts.isEmpty) {
                    return Text(
                      'No workouts tracked recently.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    );
                  }

                  return Column(
                    children:
                        recentWorkouts.map((workout) {
                          final dateStr = DateFormat(
                            'MMM d, yyyy',
                          ).format(workout.date);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF101828).withOpacity(0.55),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Left Pulse Icon Container
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF1E3A8A,
                                    ).withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/training_pulse.png',
                                    width: 20,
                                    height: 20,
                                    errorBuilder:
                                        (c, e, s) => const Icon(
                                          Icons.monitor_heart,
                                          color: Color(0xFF3B82F6),
                                          size: 20,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Workout Type & Date
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        workout.type,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        dateStr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: const Color(0xFFB3B5BA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Duration & RPE
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${workout.duration} min',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        text: 'RPE: ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: const Color(0xFFB3B5BA),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${workout.rpe}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFFFF7F7F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  );
                }),
                const SizedBox(height: 20),

                /// Quick Actions Section
                Text(
                  'Quick Actions',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                /// Quick Actions Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add Training
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Image.asset(
                          'assets/icons/training_pulse.png',
                          width: 24,
                          height: 24,
                          errorBuilder:
                              (c, e, s) => const Icon(
                                Icons.flash_on,
                                color: Colors.blue,
                              ),
                        ),
                        label: 'Add\nTraining',
                        bgColor: const Color(0xFF1E3A8A).withOpacity(0.35),
                        onTap: () {
                          Get.to(() => const AddTrainingScreen());
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Recovery
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Image.asset(
                          'assets/icons/love.png',
                          width: 24,
                          height: 24,
                          errorBuilder:
                              (c, e, s) =>
                                  const Icon(Icons.favorite, color: Colors.red),
                        ),
                        label: 'Recovery',
                        bgColor: const Color(0xFF991B1B).withOpacity(0.35),
                        onTap: () {
                          // Navigate to Recovery tab
                          dashboardController.changeTab(3);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Add Event
                    Expanded(
                      child: _buildQuickActionButton(
                        icon: Image.asset(
                          'assets/icons/calender.png',
                          width: 24,
                          height: 24,
                          errorBuilder:
                              (c, e, s) => const Icon(
                                Icons.event_note,
                                color: Colors.purple,
                              ),
                        ),
                        label: 'Add Event',
                        bgColor: const Color(0xFF581C87).withOpacity(0.35),
                        onTap: () {
                          // Navigate to Calendar tab
                          dashboardController.changeTab(2);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required Widget icon,
    required String label,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF101828).withOpacity(0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: icon,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
