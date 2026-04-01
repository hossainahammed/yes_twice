import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
          'Contact Us',
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
                'We would love it if you could share your feedback with us. It only takes a couple of minutes of your time.',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 30.h),
              
              const CustomAuthField(
                label: 'Username',
                hint: 'Type your full name',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 20.h),
              
              const CustomAuthField(
                label: 'Email address',
                hint: 'Type your email address',
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: 20.h),
              
              Text(
                'Message box',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                 decoration: BoxDecoration(
                   color: Colors.grey.shade50,
                   borderRadius: BorderRadius.circular(15.r),
                   border: Border.all(color: Colors.grey.shade300),
                 ),
                 child: TextFormField(
                   maxLines: 4,
                   style: GoogleFonts.manrope(fontSize: 14.sp),
                   decoration: InputDecoration(
                     hintText: 'Type message here...',
                     hintStyle: GoogleFonts.manrope(color: Colors.grey.shade400, fontSize: 14.sp),
                     prefixIcon: Padding(
                       padding: EdgeInsets.only(bottom: 60.h),
                       child: Icon(Icons.edit_note_outlined, color: AppColors.primaryColor.withOpacity(0.4), size: 24.sp),
                     ),
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                   ),
                 ),
              ),
              
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'Send',
                  style: GoogleFonts.manrope(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
