import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import '../../../core/widgets/app_background.dart';
import 'package:yes_twice/core/responsive/responsive_builder.dart';


class SettingsPrivacyScreen extends StatelessWidget {
  const SettingsPrivacyScreen({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Settings & Privacy',
                      style: GoogleFonts.lora(
                        fontSize: 20.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Account Section
                      _buildSectionHeader(context, 'Account'),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              context,
                              title: 'Edit Profile',
                              subtitle: 'Update your personal information',
                              icon: Icons.person_outline,
                              iconBgColor: const Color(0xFF6B4CFF),
                              onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: EditProfileScreen()))),
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              context,
                              title: 'Change Password',
                              icon: Icons.lock_outline,
                              iconBgColor: const Color(0xFF1B2A4A),
                              onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: ChangePasswordScreen()))),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// Privacy Section
                      _buildSectionHeader(context, 'Privacy'),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              context,
                              title: 'Privacy Policy',
                              subtitle: 'How we protect your data',
                              icon: Icons.security,
                              iconBgColor: const Color(0xFF2E7D32),
                              onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: PrivacyPolicyScreen()))),
                            ),
                            _buildDivider(),
                            _buildMenuItem(
                              context,
                              title: 'Terms & Conditions',
                              subtitle: 'Legal terms of service',
                              icon: Icons.description_outlined,
                              iconBgColor: const Color(0xFF00796B),
                              onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: TermsConditionScreen()))),
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
        ),

        bottomNavigationBar: const BottomNavBar(activeIndex: 4),

      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13.mq(context),
          fontWeight: FontWeight.w600,
          color: const Color(0xFFB3B5BA),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required Color iconBgColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconBgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14.mq(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: const Color(0xFFB3B5BA),
                fontSize: 11.mq(context),
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFFB3B5BA),
        size: 20,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.08),
      indent: 20,
      endIndent: 20,
    );
  }
}
