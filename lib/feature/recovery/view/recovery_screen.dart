import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../profile/view/profile_screen.dart';
import 'recovery_checkin_screen.dart';
import '../../../core/widgets/app_background.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  Color _getStatusColor(int score) {
    if (score >= 80) return const Color(0xFF10B981); // Green - Ready
    if (score >= 40) return const Color(0xFFFF7F7F); // Amber - Moderate//FF7F7F
    return const Color(0xFFEF4444); // Red - Recovery Needed
  }

  String _getStatusText(int score) {
    if (score >= 80) return 'Ready';
    if (score >= 40) return 'Moderate';
    return 'Recovery Needed';
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recovery',
                          style: GoogleFonts.poppins(
                            fontSize: 24.mq(context),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Track your wellness and recovery',
                          style: GoogleFonts.poppins(
                            fontSize: 12.mq(context),
                            color: const Color(0xFFB3B5BA),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => const RecoveryCheckinScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Check-In',
                        style: GoogleFonts.poppins(
                          fontSize: 12.mq(context),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E2A47), // Indigo blue
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                /// Statistics Row
                Obx(() {
                  final avgVal = dashboardController.avgRecovery;
                  final avgRound = avgVal.round();
                  final avgStr =
                      avgVal % 1 == 0
                          ? '$avgRound%'
                          : '${avgVal.toStringAsFixed(1)}%';
                  final statusText =
                      avgRound > 0 ? _getStatusText(avgRound) : 'No Data';
                  final statusColor =
                      avgRound > 0
                          ? _getStatusColor(avgRound)
                          : const Color(0xFFB3B5BA);

                  return Row(
                    children: [
                      // Avg Recovery Card
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Avg Recovery',
                          value: avgStr,
                          subText: statusText,
                          color: statusColor,
                          icon: Icons.analytics_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Check-Ins Card
                      Expanded(
                        child: _buildStatCard(
                          context,
                          title: 'Check-Ins',
                          value: '${dashboardController.checkins.length}',
                          subText: 'Total logs',
                          color: const Color(0xFF3B82F6),
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 28),

                /// Recent Check-Ins Section
                Text(
                  'Recent Check-Ins',
                  style: GoogleFonts.poppins(
                    fontSize: 14.mq(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                Obx(() {
                  if (dashboardController.checkins.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101828).withOpacity(0.55),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white.withOpacity(0.3),
                            size: 44,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No check-ins logged yet',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFB3B5BA),
                              fontSize: 13.mq(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardController.checkins.length,
                    itemBuilder: (context, index) {
                      final log = dashboardController.checkins[index];
                      final score = log['score'] as int;
                      final date = log['date'] as DateTime;
                      final dateStr = DateFormat('EEEE, MMMM d').format(
                        date,
                      ); // Day name, Month name with date, delete the Year
                      final timeStr = DateFormat('h:mm a').format(date);
                      final status = _getStatusText(score);
                      final statusColor = _getStatusColor(score);

                      return GestureDetector(
                        onTap:
                            () => Get.to(
                              () => RecoveryCheckinScreen(checkinToEdit: log),
                            ),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                           // color: const Color(0xFF101828).withOpacity(0.55),
                            color:AppColors.shade1,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dateStr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.mq(context),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        timeStr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.mq(context),
                                          color: const Color(0xFFB3B5BA),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$score%',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.mq(context),
                                          fontWeight: FontWeight.bold,
                                          color: statusColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        status,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.mq(context),
                                          fontWeight: FontWeight.w600,
                                          color: statusColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(color: Colors.white10, height: 1),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildMetricRow(
                                          context,
                                          'Sleep',
                                          '${log['sleep']}/10',
                                          Icons.bedtime_outlined,
                                        ),
                                        const SizedBox(height: 8),
                                        _buildMetricRow(
                                          context,
                                          'Energy',
                                          '${log['energy']}/10',
                                          Icons.flash_on_outlined,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildMetricRow(
                                          context,
                                          'Stress',
                                          '${log['stress']}/10',
                                          Icons.psychology_outlined,
                                        ),
                                        const SizedBox(height: 8),
                                        _buildMetricRow(
                                          context,
                                          'Soreness',
                                          '${log['soreness']}/10',
                                          Icons.fitness_center_outlined,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subText,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
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
                  fontSize: 11.mq(context),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFB3B5BA),
                ),
              ),
              Icon(icon, size: 16, color: color),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subText,
            style: GoogleFonts.poppins(
              fontSize: 11.mq(context),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFFB3B5BA)),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: 12.mq(context),
            color: const Color(0xFFB3B5BA),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12.mq(context),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
