import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'delete_account_confirm_page.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

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
          'Security',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.all(16.w),
            //   decoration: BoxDecoration(
            //     color: theme.cardColor,
            //     borderRadius: BorderRadius.circular(15.r),
            //     border: Border.all(color: theme.dividerColor),
            //   ),
            //   // child: Row(
            //   //   mainAxisAlignment: MainAxisAlignment.center,
            //   //   children: [
            //   //     Text(
            //   //       'Delete Account',
            //   //       style: GoogleFonts.manrope(
            //   //         fontSize: 14.sp,
            //   //         fontWeight: FontWeight.w600,
            //   //         color: textColor,
            //   //       ),
            //   //     ),
            //   //     // Icon(
            //   //     //   Icons.chevron_right,
            //   //     //   color: Colors.grey.shade400,
            //   //     //   size: 22.sp,
            //   //     // ),
            //   //   ],
            //   // ),
            // ),
            const Spacer(),
            Icon(Icons.cancel, color: const Color(0xFFD9070B), size: 80.sp),
            SizedBox(height: 24.h),
            Text(
              'DELETE ACCOUNT!',
              style: GoogleFonts.manrope(
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Oh no! You sure you want to delete your account? Once you delete your account, all your data will be cleared permanently and  cannot be undone. If you are sure click yes otherwise click no to cancel',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: subTextColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      minimumSize: Size(0, 50.h),
                    ),
                    child: Text(
                      'No',
                      style: GoogleFonts.manrope(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.to(() => const DeleteAccountConfirmPage()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      minimumSize: Size(0, 50.h),
                    ),
                    child: Text(
                      'Yes',
                      style: GoogleFonts.manrope(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
