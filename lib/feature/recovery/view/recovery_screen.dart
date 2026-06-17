import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../profile/controller/profile_controller.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  double _sleepHours = 8.0;
  double _hrv = 65.0; // 20 - 120 ms
  double _soreness = 3.0; // 1 - 10
  double _stress = 4.0; // 1 - 10

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    final profileController = Get.put(ProfileController());

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Header
                Text(
                  'Recovery Log',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Log your daily physical states to calculate your Readiness score.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFFB3B5BA),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                /// Sleep Quality Card
                _buildSliderCard(
                  title: 'Sleep Duration',
                  valueStr: '${_sleepHours.toStringAsFixed(1)} hrs',
                  slider: Slider(
                    value: _sleepHours,
                    min: 4,
                    max: 12,
                    divisions: 16,
                    activeColor: const Color(0xFFFF7F7F),
                    inactiveColor: Colors.white.withOpacity(0.1),
                    onChanged: (val) {
                      setState(() {
                        _sleepHours = val;
                      });
                    },
                  ),
                  caption: 'How long did you rest last night?',
                ),
                const SizedBox(height: 14),

                /// HRV Card
                _buildSliderCard(
                  title: 'HRV (Heart Rate Variability)',
                  valueStr: '${_hrv.round()} ms',
                  slider: Slider(
                    value: _hrv,
                    min: 20,
                    max: 120,
                    divisions: 100,
                    activeColor: const Color(0xFFFF7F7F),
                    inactiveColor: Colors.white.withOpacity(0.1),
                    onChanged: (val) {
                      setState(() {
                        _hrv = val;
                      });
                    },
                  ),
                  caption: 'Indicates autonomic nervous system balance.',
                ),
                const SizedBox(height: 14),

                /// Muscle Soreness Card
                _buildSliderCard(
                  title: 'Muscle Soreness',
                  valueStr: '${_soreness.round()} / 10',
                  slider: Slider(
                    value: _soreness,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    activeColor: const Color(0xFFFF7F7F),
                    inactiveColor: Colors.white.withOpacity(0.1),
                    onChanged: (val) {
                      setState(() {
                        _soreness = val;
                      });
                    },
                  ),
                  caption: '1 = Fully recovered, 10 = Severe fatigue/soreness.',
                ),
                const SizedBox(height: 14),

                /// Stress Level Card
                _buildSliderCard(
                  title: 'Stress Level',
                  valueStr: '${_stress.round()} / 10',
                  slider: Slider(
                    value: _stress,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    activeColor: const Color(0xFFFF7F7F),
                    inactiveColor: Colors.white.withOpacity(0.1),
                    onChanged: (val) {
                      setState(() {
                        _stress = val;
                      });
                    },
                  ),
                  caption: '1 = Fully relaxed, 10 = Under intense cognitive load.',
                ),
                const SizedBox(height: 28),

                /// Save Action Button
                ElevatedButton(
                  onPressed: () {
                    // Simple heuristic algorithm to calculate Readiness (0 - 100)
                    // Sleep contribution: up to 35% (8 hrs is optimal)
                    double sleepScore = (_sleepHours / 8.0) * 35.0;
                    if (sleepScore > 35.0) sleepScore = 35.0;

                    // HRV contribution: up to 30% (70 ms is optimal)
                    double hrvScore = (_hrv / 70.0) * 30.0;
                    if (hrvScore > 30.0) hrvScore = 30.0;

                    // Soreness contribution (inverse): up to 20%
                    double sorenessScore = ((10.0 - _soreness) / 9.0) * 20.0;

                    // Stress contribution (inverse): up to 15%
                    double stressScore = ((10.0 - _stress) / 9.0) * 15.0;

                    int readinessVal = (sleepScore + hrvScore + sorenessScore + stressScore).round();
                    if (readinessVal < 10) readinessVal = 10;
                    if (readinessVal > 100) readinessVal = 100;

                    // Update Readiness in Dashboard Controller
                    dashboardController.updateReadiness(readinessVal);
                    
                    // Increment check-ins count in Profile Controller
                    profileController.checkinsCount.value++;

                    // Navigate to Home screen
                    dashboardController.changeTab(0);

                    // Show visual success notification
                    Get.snackbar(
                      'Recovery Tracked',
                      'Readiness updated to $readinessVal%!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF10B981).withOpacity(0.9),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7F7F),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Log Recovery & Update Readiness',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderCard({
    required String title,
    required String valueStr,
    required Widget slider,
    required String caption,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                valueStr,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF7F7F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          slider,
          const SizedBox(height: 4),
          Text(
            caption,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFFB3B5BA),
            ),
          ),
        ],
      ),
    );
  }
}
