import 'package:bolaji277/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'review_page.dart';
import 'all_reviews_page.dart';

class DishDetailsPage extends StatelessWidget {
  const DishDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const CustomBackButton(),
        ),
        title: Text(
          'Details',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDishImages(context),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pizza',
                          style: GoogleFonts.manrope(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: context.theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.orange,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '4.9',
                              style: GoogleFonts.manrope(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                                color: context.theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '(450)',
                              style: GoogleFonts.manrope(
                                fontSize: 11.sp,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                    GestureDetector(
                      onTap: () {
                        if (AuthService.to.checkAuthAndPrompt()) {
                          // Logic to bookmark
                        }
                      },
                      child: Icon(
                        Icons.bookmark_border_rounded,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () => _showShareBottomSheet(context),
                          child: Transform.flip(
                            flipX: true,
                            child: Icon(
                              Icons.reply_rounded,
                              color: context.theme.textTheme.bodyLarge?.color,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Description',
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: context.theme.textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Savor the crispy, golden-brown crust topped with rich, slow-simmered tomato sauce, premium mozzarella, and fresh basil. Our artisanal pizzas are hand-stretched and baked in a traditional wood-fired oven for a perfect smoky finish.',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24.h),
                _buildSectionHeader(
                  context,
                  'Recent Reviews',
                  () => Get.to(() => const AllReviewsPage()),
                ),
                SizedBox(height: 16.h),
                _buildSampleReview(context),
                SizedBox(height: 30.h),
              ],
            ),
          ),
          Positioned(
            left: 24.w,
            right: 24.w,
            bottom: 24.h,
            child: ElevatedButton(
              onPressed: () {
                if (AuthService.to.checkAuthAndPrompt()) {
                  Get.to(
                    () => const ReviewPage(
                      name: 'Pizza',
                      rating: '4.9',
                      imagePath: 'assets/images/pizza.png',
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Add review',
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishImages(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final placeholderColor = isDark ? Colors.grey[800] : Colors.grey[200];

    return SizedBox(
      height: 250.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                'assets/images/pizza.png',
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: double.infinity, color: placeholderColor),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      'assets/images/burger.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        color: placeholderColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/restaurent.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: double.infinity,
                                color: placeholderColor,
                              ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: Text(
                              '+5',
                              style: GoogleFonts.manrope(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                'See all',
                style: GoogleFonts.manrope(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: context.theme.brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: context.theme.brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.primaryColor,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSampleReview(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                'assets/images/Composer.png',
                width: 40.w,
                height: 40.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 40.w,
                  height: 40.h,
                  color: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kurt Bates',
                        style: GoogleFonts.manrope(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          color: context.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < 5 ? Colors.orange : Colors.grey[200],
                            size: 10.sp,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'The pizza was amazing, definitely coming back!',
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: context.theme.textTheme.bodyLarge?.color,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Share',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              Divider(color: Colors.grey[200], thickness: 1),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    context,
                    'Copy Link',
                    Icons.copy,
                    AppColors.primaryColor,
                  ),
                  _buildShareOption(
                    context,
                    'WhatsApp',
                    Icons.chat,
                    Colors.green,
                  ),
                  _buildShareOption(
                    context,
                    'Instagram',
                    Icons.camera_alt,
                    Colors.pink,
                  ),
                  _buildShareOption(
                    context,
                    'TikTok',
                    Icons.music_note,
                    Colors.black,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
