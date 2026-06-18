import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'profile_screen.dart';
import '../../../core/widgets/app_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Privacy & Policy',
                      style: GoogleFonts.lora(
                        fontSize: 20.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),

                      /// Section 1: Information We Collect
                      Row(
                        children: [
                          const Icon(
                            Icons.article_outlined,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Information We Collect',
                            style: GoogleFonts.lora(
                              fontSize: 15.mq(context),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildPolicyCard(
                        context,
                        title: 'ACCOUNT INFO',
                        content:
                            'Email addresses are hashed immediately. We do not store real names unless explicitly provided for billing.',
                      ),
                      _buildPolicyCard(
                        context,
                        title: 'USAGE DATA',
                        content:
                            'Anonymous telemetry to improve app performance. No individual session tracking is ever enabled.',
                      ),
                      _buildPolicyCard(
                        context,
                        title: 'DEVICE IDENTIFIERS',
                        content:
                            'Operating system version and device model for optimization.',
                      ),
                      _buildPolicyCard(
                        context,
                        title: 'DEVICE IDENTIFIERS',
                        content:
                            'Operating system version and device model for optimization.',
                      ),

                      const SizedBox(height: 28),

                      /// Section 2: How We Process Data
                      Row(
                        children: [
                          const Icon(
                            Icons.shield_outlined,
                            color: Color(0xFFFF7F7F),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'How We Process Data',
                            style: GoogleFonts.lora(
                              fontSize: 15.mq(context),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildPolicyCard(
                        context,
                        title: 'Zero-Knowledge Architecture',
                        content:
                            'We cannot access your data. All encryption keys are generated locally on your device and never transit through our servers.',
                      ),
                      _buildPolicyCard(
                        context,
                        title: 'Optimization',
                        content:
                            'Personalize your training blocks based on your real-time recovery metrics and performance history.',
                      ),
                      _buildPolicyCard(
                        context,
                        title: 'Analytics',
                        content:
                            'Generate deep-dive reports on your progress toward elite athletic benchmarks.',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: const BottomNavBar(activeIndex: 4),

      ),
    );
  }

  Widget _buildPolicyCard(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11.mq(context),
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 13.mq(context),
              height: 1.4,
              color: const Color(0xFFB3B5BA),
            ),
          ),
        ],
      ),
    );
  }
}
