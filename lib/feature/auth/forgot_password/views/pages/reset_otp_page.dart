import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/feature/auth/forgot_password/views/pages/reset_password_page.dart';

class ResetOtpPage extends StatefulWidget {
  const ResetOtpPage({super.key});

  @override
  State<ResetOtpPage> createState() => _ResetOtpPageState();
}

class _ResetOtpPageState extends State<ResetOtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
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
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please type the verification code',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
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
                      /// OTP boxes row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) => _buildOtpField(index)),
                      ),

                      const SizedBox(height: 32),

                      /// Verify Button
                      ElevatedButton(
                        onPressed: () {
                          // Join fields and check validation
                          final otp = _controllers.map((c) => c.text).join();
                          if (otp.length == 5) {
                            Get.to(() => const ResetPasswordPage());
                          } else {
                            Get.snackbar(
                              'Invalid OTP',
                              'Please enter the 5-digit code',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withValues(alpha: 0.8),
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Get.until((route) => route.isFirst),
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
