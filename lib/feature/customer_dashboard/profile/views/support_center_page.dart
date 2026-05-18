import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'contact_us_page.dart';

class SupportCenterPage extends StatelessWidget {
  const SupportCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Support Center',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: theme.textTheme.bodyLarge?.color,
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
                'How can we help you?',
                style: GoogleFonts.manrope(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Have questions? We have answers. If you can\'t find what you\'re looking for, feel free to contact us.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 32.h),
              _buildFaqItem(
                context,
                'How do I update my reserved table?',
                'To update your reservation, go to the My Reservations tab, select the booking and tap "Edit". You can adjust your reservation details up to 2 hours before the scheduled time.',
              ),
              _buildFaqItem(
                context,
                'What happens if I\'m late for my reservation?',
                'We hold reservations for an additional 15 minutes past the scheduled time. After that, we may need to release the table or item. Please contact us if you are running late.',
              ),
              _buildFaqItem(
                context,
                'Can I reserve for someone else?',
                'Yes, you can specify the guest name and contact details when making the reservation. Please make sure they check in under their name.',
              ),
              _buildFaqItem(
                context,
                'Is there a cancellation fee?',
                'Most reservations can be cancelled for free up to 24 hours in advance. Please check the specific restaurant policy for details.',
              ),

              SizedBox(height: 12.h),
              Text(
                'Have questions? We have answers. If you can\'t find what you\'re looking for, feel free to contact us.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => Get.to(() => const ContactUsPage()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Contact Us',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.dividerColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: GoogleFonts.manrope(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          iconColor: AppColors.primaryColor,
          collapsedIconColor: Colors.grey,
          childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
          expandedAlignment: Alignment.topLeft,
          children: [
            Text(
              answer,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
