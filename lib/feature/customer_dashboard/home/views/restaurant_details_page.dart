import 'package:bolaji277/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'package:bolaji277/feature/auth/claim/views/claim_page.dart';
import 'gallery_page.dart';
import 'review_page.dart';
import 'all_reviews_page.dart';
import 'dish_list_page.dart';
import 'dish_details_page.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Details',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: TextButton(
              onPressed: () => Get.to(() => const ClaimPage()),
              child: Text(
                'Claim Restaurant',
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: context.theme.brightness == Brightness.dark
                      ? AppColors.secondaryColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageGallery(),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: _buildSeeMoreButton(),
                ),
                SizedBox(height: 16.h),
                _buildHeaderRow(context),
                SizedBox(height: 8.h),
                _buildInfoRows(context),
                SizedBox(height: 20.h),
                Container(height: 1, color: context.theme.dividerColor),
                SizedBox(height: 16.h),
                _buildDescriptionSection(context),
                SizedBox(height: 16.h),
                _buildContactInfo(context),
                SizedBox(height: 20.h),
                Container(height: 1, color: context.theme.dividerColor),
                SizedBox(height: 16.h),
                _buildSectionHeader(
                  context,
                  'Dishes',
                  () => Get.to(() => const DishListPage()),
                ),
                SizedBox(height: 12.h),
                _buildDishesList(context),
                SizedBox(height: 20.h),
                Container(height: 1, color: Colors.grey.shade100),
                SizedBox(height: 16.h),
                _buildSectionHeader(
                  context,
                  'Recent Reviews',
                  () => Get.to(() => const AllReviewsPage()),
                ),
                SizedBox(height: 12.h),
                _buildRecentReviews(context),
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
                  Get.to(() => const ReviewPage());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                minimumSize: Size(double.infinity, 52.h),
              ),
              child: Text(
                'Add review',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: 250.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                'assets/images/restaurent.png',
                fit: BoxFit.cover,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[200]),
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
                      'assets/images/nearbyresturants.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      'assets/images/popularFoodSpots.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      'assets/images/food01.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[200]),
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

  Widget _buildSeeMoreButton() {
    return GestureDetector(
      onTap: () => Get.to(() => const GalleryPage()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.grid_view_rounded, color: Colors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'See More',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Smokehouse',
          style: GoogleFonts.manrope(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
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
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () => _showShareBottomSheet(context),
              child: Transform.flip(
                flipX: true,
                child: Icon(
                  Icons.reply_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRows(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primaryColor, size: 12.sp),
            SizedBox(width: 4.w),
            Text(
              'Asian · 2.5 mile',
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(
              Icons.access_time_filled,
              color: AppColors.primaryColor,
              size: 12.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              '08:00 - 22:00  ',
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'OPEN',
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Description',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: context.theme.textTheme.bodyLarge?.color,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 12.sp),
                SizedBox(width: 4.w),
                Text(
                  '4.9',
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: context.theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Smokehouse brings the bold flavors of Southern-style barbecue to your plate with slow-cooked, fall-off-the-bone meats, house-made sauces, and hearty sides. Known for its signature smoked ribs and pulled pork sandwiches, this casual spot combines rustic charm with mouthwatering comfort food.',
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            color: Colors.grey[400],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.phone, color: AppColors.primaryColor, size: 14.sp),
            SizedBox(width: 8.w),
            Text(
              '123-456-7890',
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: context.theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primaryColor, size: 14.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '123 Foodie Lane, Johannesburg, SA',
                style: GoogleFonts.manrope(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: context.theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
      ],
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
                  color: context.theme.brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
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

  Widget _buildDishesList(BuildContext context) {
    final dishes = [
      {'name': 'Pizza', 'image': 'assets/images/pizza.png', 'rating': '4.9'},
      {
        'name': 'Chinese',
        'image': 'assets/images/restaurent.png',
        'rating': '4.9',
      },
      {'name': 'Burgers', 'image': 'assets/images/burger.png', 'rating': '4.9'},
    ];

    return Column(
      children: dishes.map((dish) {
        return GestureDetector(
          onTap: () => Get.to(() => const DishDetailsPage()),
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
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
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    dish['image']!,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60.w,
                      height: 60.w,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish['name']!,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: context.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            dish['rating']!,
                            style: GoogleFonts.manrope(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w800,
                              color: context.theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(450)',
                            style: GoogleFonts.manrope(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        r'$$$',
                        style: GoogleFonts.manrope(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (AuthService.to.checkAuthAndPrompt()) {
                      Get.to(
                        () => ReviewPage(
                          name: dish['name']!,
                          rating: dish['rating']!,
                          imagePath: dish['image']!,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: context.theme.brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      'Review',
                      style: GoogleFonts.manrope(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: context.theme.brightness == Brightness.dark
                            ? Colors.white
                            : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentReviews(BuildContext context) {
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    'assets/images/recentViewCard.png',
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
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
                                color: Colors.orange,
                                size: 10.sp,
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod.',
                        style: GoogleFonts.manrope(
                          fontSize: 10.sp,
                          color: context.theme.textTheme.bodyLarge?.color,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
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
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurfaceColor
                : Colors.white,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Share',
                style: GoogleFonts.manrope(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    context,
                    title: 'Copy Link',
                    icon: Icons.copy,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  _buildShareOption(
                    context,
                    title: 'WhatsApp',
                    icon: Icons.chat,
                    backgroundColor: Colors.green,
                  ),
                  _buildShareOption(
                    context,
                    title: 'Instagram',
                    icon: Icons.camera_alt,
                    isGradient: true,
                  ),
                  _buildShareOption(
                    context,
                    title: 'TikTok',
                    icon: Icons.music_note,
                    backgroundColor: Colors.pinkAccent,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    Color? backgroundColor,
    bool isGradient = false,
  }) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: isGradient ? null : backgroundColor,
            gradient: isGradient
                ? const LinearGradient(
                    colors: [
                      Color(0xFF833AB4),
                      Color(0xFFFD1D1D),
                      Color(0xFFF56040),
                      Color(0xFFFFDC80),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                : null,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(icon, color: Colors.white, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ],
    );
  }
}
