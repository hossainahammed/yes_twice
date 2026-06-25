import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/core/constant/widgets/profile_bottom_nav_bar.dart';
import '../controller/profile_controller.dart';
import 'settings_privacy_screen.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../../../core/widgets/app_background.dart';
import 'package:yes_twice/core/responsive/responsive_builder.dart';


export 'package:yes_twice/core/constant/widgets/profile_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
                        fontSize: 26.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: SettingsPrivacyScreen()))),
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
                        child: Icon(
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
                            fontSize: 22.mq(context),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.email.value,
                          style: GoogleFonts.poppins(
                            fontSize: 13.mq(context),
                            color: const Color(0xFFB3B5BA),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Football',
                          style: GoogleFonts.poppins(
                            fontSize: 12.mq(context),
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
                            context,
                            icon: Image.asset(
                              'assets/icons/training_pulse.png',
                              width: 24,
                              height: 24,
                            ),
                            value: '${controller.trainingCount.value}',
                            label: 'Training',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            context,
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
                            context,
                            icon: Image.asset('assets/icons/event_icon.png',
                            width: 24,
                            height: 24,
                            ),
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
                          fontSize: 15.mq(context),
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
                              fontSize: 12.mq(context),
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
                                      fontSize: 13.mq(context),
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
                          fontSize: 15.mq(context),
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
                                color:AppColors.whiteColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Clear All Data',
                                style: GoogleFonts.poppins(
                                  color:AppColors.whiteColor,
                                  fontSize: 13.mq(context),
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
                          fontSize: 14.mq(context),
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

  Widget _buildStatCard(
    BuildContext context, {
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
          icon,
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11.mq(context),
              color: const Color(0xFFB3B5BA),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

