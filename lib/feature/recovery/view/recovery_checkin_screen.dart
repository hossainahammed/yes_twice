import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/view/profile_screen.dart';

class RecoveryCheckinScreen extends StatefulWidget {
  final Map<String, dynamic>? checkinToEdit;
  const RecoveryCheckinScreen({super.key, this.checkinToEdit});

  @override
  State<RecoveryCheckinScreen> createState() => _RecoveryCheckinScreenState();
}

class RecoverySliderThumbShape extends SliderComponentShape {
  final double enabledThumbRadius;

  const RecoverySliderThumbShape({this.enabledThumbRadius = 10.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint =
        Paint()
          ..color = const Color.fromARGB(255, 58, 94, 148)
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = const Color(0xFFFF7F7F)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, enabledThumbRadius, fillPaint);
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);
  }
}

class _RecoveryCheckinScreenState extends State<RecoveryCheckinScreen> {
  int _sleep = 7;
  int _energy = 7;
  int _stress = 3;
  int _soreness = 3;

  @override
  void initState() {
    super.initState();
    if (widget.checkinToEdit != null) {
      _sleep = widget.checkinToEdit!['sleep'] as int? ?? 7;
      _energy = widget.checkinToEdit!['energy'] as int? ?? 7;
      _stress = widget.checkinToEdit!['stress'] as int? ?? 3;
      _soreness = widget.checkinToEdit!['soreness'] as int? ?? 3;
    }
  }

  int _calculateReadiness() {
    double raw = 3.6 * (_sleep + _energy) - 2.85 * (_stress + _soreness) + 36.7;
    return raw.round().clamp(10, 100);
  }

  String _getReadinessStatus(int score) {
    if (score >= 80) return 'Ready';
    if (score >= 40) return 'Moderate';
    return 'Recovery Needed';
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();
    final profileController = Get.find<ProfileController>();

    final readiness = _calculateReadiness();
    final status = _getReadinessStatus(readiness);
    final isEditing = widget.checkinToEdit != null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.8),
            radius: 1.5,
            colors: [Color(0xFF2B1416), Color(0xFF080808)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEditing ? 'Edit Check-in' : 'Recovery Check in',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Save Button
                    GestureDetector(
                      onTap: () {
                        final now = DateTime.now();

                        if (isEditing) {
                          final index = dashboardController.checkins.indexWhere(
                            (c) => c['id'] == widget.checkinToEdit!['id'],
                          );
                          if (index != -1) {
                            dashboardController.checkins[index] = {
                              'id': widget.checkinToEdit!['id'],
                              'date': widget.checkinToEdit!['date'],
                              'score': readiness,
                              'sleep': _sleep,
                              'energy': _energy,
                              'stress': _stress,
                              'soreness': _soreness,
                            };
                            dashboardController.checkins.refresh();
                          }
                        } else {
                          dashboardController.checkins.insert(0, {
                            'id': now.millisecondsSinceEpoch.toString(),
                            'date': now,
                            'score': readiness,
                            'sleep': _sleep,
                            'energy': _energy,
                            'stress': _stress,
                            'soreness': _soreness,
                          });
                        }

                        if (dashboardController.checkins.isNotEmpty) {
                          dashboardController.updateReadiness(
                            dashboardController.checkins.first['score'] as int,
                          );
                        }

                        profileController.checkinsCount.value =
                            dashboardController.checkins.length;

                        Get.back();
                        Get.snackbar(
                          isEditing ? 'Check-in Updated' : 'Check-in Logged',
                          'Readiness score updated to $readiness%.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(
                            0xFF1E3A8A,
                          ).withOpacity(0.9),
                          colorText: Colors.white,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.saveButtonBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.bookmark_border_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Save',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable sliders
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Readiness Summary Card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2E1517), Color(0xFF1E0F10)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF3F1F22)),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Text('👍', style: TextStyle(fontSize: 36)),
                            const SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Readiness',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFB3B5BA),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$readiness%',
                                    style: GoogleFonts.poppins(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF7F7F),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    status,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFB3B5BA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Sleep Quality Slider Card
                      _buildSliderCard(
                        title: 'Sleep Quality',
                        valueStr: '$_sleep/10',
                        slider: Slider(
                          value: _sleep.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (val) {
                            setState(() {
                              _sleep = val.round();
                            });
                          },
                        ),
                        leftCaption: '😢 Poor',
                        rightCaption: '😊 Excellent',
                      ),
                      const SizedBox(height: 14),

                      /// Energy Level Slider Card
                      _buildSliderCard(
                        title: 'Energy Level',
                        valueStr: '$_energy/10',
                        slider: Slider(
                          value: _energy.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (val) {
                            setState(() {
                              _energy = val.round();
                            });
                          },
                        ),
                        leftCaption: '🔋 Low',
                        rightCaption: '⚡ High',
                      ),
                      const SizedBox(height: 14),

                      /// Stress Level Slider Card
                      _buildSliderCard(
                        title: 'Stress Level',
                        valueStr: '$_stress/10',
                        slider: Slider(
                          value: _stress.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (val) {
                            setState(() {
                              _stress = val.round();
                            });
                          },
                        ),
                        leftCaption: '😔 Low',
                        rightCaption: '😰 High',
                      ),
                      const SizedBox(height: 14),

                      /// Muscle Soreness Slider Card
                      _buildSliderCard(
                        title: 'Muscle Soreness',
                        valueStr: '$_soreness/10',
                        slider: Slider(
                          value: _soreness.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (val) {
                            setState(() {
                              _soreness = val.round();
                            });
                          },
                        ),
                        leftCaption: '💪 None',
                        rightCaption: '🤕 Very Sore',
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 3),
    );
  }

  Widget _buildSliderCard({
    required String title,
    required String valueStr,
    required Widget slider,
    required String leftCaption,
    required String rightCaption,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF111C2B),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                valueStr,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF7F7F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 12,
              activeTrackColor: const Color(0xFFD1D5DB),
              inactiveTrackColor: const Color(0xFF111721),
              thumbColor: const Color(0xFFD1D5DB),
              overlayColor: const Color(0xFFFF7F7F).withOpacity(0.15),
              thumbShape: const RecoverySliderThumbShape(
                enabledThumbRadius: 10.0,
              ),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: slider,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leftCaption,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB3B5BA),
                  ),
                ),
                Text(
                  rightCaption,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFB3B5BA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
