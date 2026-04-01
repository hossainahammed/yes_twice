import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Privacy & Policy',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              _buildSection(
                '1. User License & Restrictions',
                'By accessing or using our application, we grant you a limited, non-exclusive, non-transferable license to download, install, and use the Application strictly in accordance with these Terms.\n\nYou shall not:\n- Decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the Application;\n- Make any modification, adaptation, improvement, enhancement, translation, or derivative work from the Application;\n- Violate any applicable laws, rules, or regulations in connection with your access or use of the Application.',
              ),
              _buildSection(
                '2. Terms of Payment',
                'Any financial transactions you perform within the application will be securely processed. You agree to provide a valid payment method. Transactions are final, but if you have continuous issues, you can engage Support Center.',
              ),
              _buildSection(
                '3. Security',
                'We use industry-standard security measures to ensure your data is secure. However, no digital system is completely invulnerable. You are responsible for preserving your account credentials.',
              ),
              _buildSection(
                '4. Data Privacy',
                'Your privacy is critical to us. We will only use your data in accordance to the agreed upon guidelines, ensuring full transparency in our data protection standards.',
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
