import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'profile_screen.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Terms & Condition',
                      style: GoogleFonts.lora(
                        fontSize: 20.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable Terms Content
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

                      /// Top Document Card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF101828,
                          ).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Terms & Condition',
                              style: GoogleFonts.lora(
                                fontSize: 16.mq(context),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Introductory Summary block
                      _buildSummaryBlock(
                        context,
                        'This Terms of Service agreement governs your access to and use of our mobile application and elite performance platform. By accessing the platform, you acknowledge you have read and agreed to these terms.',
                      ),

                      const SizedBox(height: 16),

                      /// Sections
                      _buildTermsSection(
                        context,
                        title: 'ACCEPTANCE OF TERMS',
                        content:
                            'By downloading, installing, or using this application, you agree to be bound by these Terms of Service. If you do not agree to all terms, you are prohibited from using the platform and must delete all cached data immediately.',
                      ),

                      _buildTermsSection(
                        context,
                        title: 'PERFORMANCE DATA',
                        content:
                            'All metrics provided by this application, including heart rate variability (HRV), readiness scores, and intensity targets, are for personal growth and educational purposes only.',
                      ),

                      _buildTermsSection(
                        context,
                        title: 'AS-IS WARRANTY',
                        content:
                            'We provide the platform and data on an "as-is" and "as-available" basis. It is not a medical device and should not be used to diagnose or treat any medical condition. Always consult with a licensed professional before beginning an intensive training regimen.',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 4),
    );
  }

  Widget _buildSummaryBlock(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13.mq(context),
          height: 1.4,
          color: const Color(0xFFB3B5BA),
        ),
      ),
    );
  }

  Widget _buildTermsSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              height: 1.45,
              color: const Color(0xFFB3B5BA),
            ),
          ),
        ],
      ),
    );
  }
}
