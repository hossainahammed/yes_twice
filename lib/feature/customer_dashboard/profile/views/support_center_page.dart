import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import 'contact_us_page.dart';

class SupportCenterPage extends StatelessWidget {
  const SupportCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildFaqList(),
                  SizedBox(height: 20.h),
                  _buildNeedHelpCard(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 30.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Get.theme.dividerColor),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: Get.theme.iconTheme.color,
                ),
              ),
            ),
          ),
          Text(
            "Support Center",
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqList() {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFaqItem(
            "How do I update my reserved table?",
            'To update your reservation, go to the My Reservations tab, select the booking and tap "Edit". You can adjust your reservation details up to 2 hours before the scheduled time.',
          ),
          _buildDivider(),
          _buildFaqItem(
            "What happens if I'm late for my reservation?",
            "We hold reservations for an additional 15 minutes past the scheduled time. After that, we may need to release the table or item. Please contact us if you are running late.",
          ),
          _buildDivider(),
          _buildFaqItem(
            "Can I reserve for someone else?",
            "Yes, you can specify the guest name and contact details when making the reservation. Please make sure they check in under their name.",
          ),
          _buildDivider(),
          _buildFaqItem(
            "Is there a cancellation fee?",
            "Most reservations can be cancelled for free up to 24 hours in advance. Please check the specific restaurant policy for details.",
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Get.theme.dividerColor.withOpacity(0.5),
      height: 1,
      thickness: 1,
      indent: 16.w,
      endIndent: 16.w,
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        iconColor: Get.theme.iconTheme.color,
        collapsedIconColor: Get.theme.iconTheme.color,
        childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        children: [
          Text(
            answer,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: Colors.grey.shade400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeedHelpCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Need help setting up?",
            style: GoogleFonts.manrope(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Our support team can help you verify your documents and get your services live in under 24 hours.",
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Get.theme.textTheme.bodyLarge?.color?.withOpacity(0.8) ?? Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const ContactUsPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.brightness == Brightness.dark
                  ? AppColors.primaryColor
                  : const Color(0xFF4C080C),
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              "Contact Us",
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
