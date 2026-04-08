import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class ClaimPage extends StatefulWidget {
  const ClaimPage({super.key});

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  bool isChecked = false;
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  const CustomBackButton(),
                  SizedBox(width: 16.w),
                  Text(
                    'Claim Restaurant',
                    style: GoogleFonts.manrope(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              const CustomAuthField(
                label: 'Restaurant Name',
                hint: 'Enter Restaurant Name',
                prefixIcon: Icons.storefront_outlined,
              ),
              SizedBox(height: 20.h),

              const CustomAuthField(
                label: 'Email Address',
                hint: 'Enter Email',
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: 20.h),

              CustomAuthField(
                label: 'Choose Password',
                hint: 'Enter a secure password',
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                obscureText: isPasswordHidden,
                onSuffixIconPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
              ),
              SizedBox(height: 25.h),

              Text(
                'Proof Upload',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              SizedBox(height: 8.h),

              CustomPaint(
                painter: DashedRectPainter(
                  color: AppColors.secondaryColor.withOpacity(0.5),
                  strokeWidth: 1.5,
                  gap: 6.0,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: context.theme.brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.primaryColor,
                        size: 28.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Upload Photo',
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: context.theme.brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          minimumSize: Size(120.w, 36.h),
                          elevation: 0,
                        ),
                        child: Text(
                          'Choose File',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: TextFormField(
                  maxLines: 4,
                  style: GoogleFonts.manrope(fontSize: 14.sp, color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Message Box',
                    hintStyle: GoogleFonts.manrope(
                      color: Colors.grey.shade400,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 50.h),
                      child: Icon(
                        Icons.edit_note_outlined,
                        color: context.theme.brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h, right: 12.w),
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        color: isChecked
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: isChecked
                              ? AppColors.primaryColor
                              : subTextColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: isChecked
                          ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'By submitting a claim for this restaurant, you confirm that you are the rightful owner or an authorised representative of the business. All claims are subject to verification and approval by our team. Submitting false or misleading information may result in removal of access and possible legal action. We reserve the right to request additional documentation to verify ownership. Until approved, the restaurant will remain publicly listed as unclaimed.',
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor.withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  minimumSize: Size(double.infinity, 56.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
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
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path();
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(15.r));
    path.addRRect(rrect);

    var dashPath = Path();
    double dashLength = gap;
    bool draw = true;
    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < measurePath.length) {
        if (draw) {
          dashPath.addPath(
            measurePath.extractPath(distance, distance + dashLength),
            Offset.zero,
          );
        }
        distance += dashLength;
        draw = !draw;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
