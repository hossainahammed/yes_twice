import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/feature/auth/forgot_password/views/pages/reset_otp_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.7, -0.7),
            radius: 1.2,
            colors: [
              Color(0xFF2B1416),
              Color(0xFF080808),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  /// Back to Login Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildBackButton(),
                  ),

                  const SizedBox(height: 40),

                  /// Pulse logo icon
                  Center(
                    child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          // color: const Color(0xFF1E1012),
                          //color: const Color(0xFF101828).withValues(alpha: 0.55),
                          color: AppColors.shade1,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            // color: const Color(0xFFFF7F7F).withValues(alpha: 0.15),
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child:
                        Image.asset('assets/icons/login_heart.png')
                      // const Icon(
                      //  // Icons.monitor_heart,
                      //   color: Color(0xFFFF7F7F),
                      //   size: 24,
                      // ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Heading & Subtitle
                  Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 28.mq(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "No worries, we'll send you reset instructions",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13.mq(context),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFB3B5BA),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101828).withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Email Input
                        _buildInputField(
                          label: 'Email Address',
                          hint: 'you@example.com',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 8),

                        /// Helper text
                        Text(
                          "We'll send a verification code to this email",
                          style: GoogleFonts.poppins(
                            fontSize: 11.mq(context),
                            color: Colors.grey.shade500,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Send Reset Code Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Get.to(() => const ResetOtpPage());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text('Send Reset Code'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              'Back to Login',
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13.mq(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.mq(context),
            fontWeight: FontWeight.w500,
            color: const Color(0xFFB3B5BA),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14.mq(context)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14.mq(context),
            ),
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade400, size: 20),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.35),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            errorStyle: GoogleFonts.poppins(fontSize: 11.mq(context)),
          ),
        ),
      ],
    );
  }
}
