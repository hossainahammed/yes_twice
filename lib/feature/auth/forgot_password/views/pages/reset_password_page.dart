import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/feature/auth/login/views/login_page.dart';
import 'package:yes_twice/core/responsive/responsive_builder.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    'Set New Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 28.mq(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a strong new password to secure your account.',
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
                        /// Password
                        _buildInputField(
                          label: 'Password',
                          hint: 'At least 8 characters',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          controller: _passwordController,
                          onToggleVisibility: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        const SizedBox(height: 18),

                        /// Confirm Password
                        _buildInputField(
                          label: 'Confirm Password',
                          hint: 'Re-enter your password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          controller: _confirmPasswordController,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        /// Update Password Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Get.snackbar(
                                'Success',
                                'Password updated successfully!',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green.withValues(alpha: 0.8),
                                colorText: Colors.white,
                              );
                              Get.offAll(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: LoginPage())));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Text('Update Password'),
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
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
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
          obscureText: isPassword && obscureText,
          validator: validator ??
              (value) {
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
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
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
