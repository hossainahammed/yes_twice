import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/core/constant/image_path.dart';
import 'package:yes_twice/feature/auth/registration/views/registration_page.dart';
import 'package:yes_twice/feature/auth/forgot_password/views/forgot_password_page.dart';
import 'package:yes_twice/feature/onboarding/view/onboarding_screen.dart';
import 'package:yes_twice/feature/profile/view/profile_screen.dart';
import 'package:yes_twice/feature/dashboard/view/dashboard_screen.dart';
import 'package:yes_twice/core/responsive/responsive_builder.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            colors: [Color(0xFF2B1416), Color(0xFF080808)],
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
                  const SizedBox(height: 20),

                  /// EKG pulse logo
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
                      child: Image.asset('assets/icons/login_heart.png'),
                      // const Icon(
                      //  // Icons.monitor_heart,
                      //   color: Color(0xFFFF7F7F),
                      //   size: 24,
                      // ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Header
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 28.mq(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Precision performance starts here',
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
                        /// Email Address
                        _buildInputField(
                          label: 'Email Address',
                          hint: 'you@example.com',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 18),

                        /// Password
                        _buildInputField(
                          label: 'Secure Password',
                          hint: '••••••••',
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
                        const SizedBox(height: 14),

                        /// Remember me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    activeColor: AppColors.primaryColor,
                                    checkColor: Colors.white,
                                    side: BorderSide(
                                      color: Colors.white.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Remember me',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFB3B5BA),
                                    fontSize: 12.mq(context),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: ForgotPasswordPage()))),
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF7F7F),
                                  fontSize: 12.mq(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// Log in Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              //  Get.offAll(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: DashboardScreen())));
                              Get.offAll(() => ResponsiveCenteredWrapper(child: OnboardingScreen()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Text('Log in'),
                        ),

                        const SizedBox(height: 20),

                        /// OR Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'Or continue with',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.mq(context),
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Google Button
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black.withValues(alpha: 0.3,),
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                ImagePath.google,
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14.mq(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 13.mq(context),
                          color: const Color(0xFFB3B5BA),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const ResponsiveCenteredWrapper(child: ResponsiveCenteredWrapper(child: RegistrationPage()))),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 13.mq(context),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF7F7F),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
          obscureText: isPassword && obscureText,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14.mq(context),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14.mq(context),
            ),
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade400, size: 20),
            suffixIcon:
                isPassword
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
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
              ),
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
