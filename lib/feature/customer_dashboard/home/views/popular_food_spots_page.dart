import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart'; // For CustomBackButton
import '../models/home_models.dart';
import '../controllers/home_controller.dart';
import 'restaurant_details_page.dart';

class PopularFoodSpotsPage extends StatelessWidget {
  PopularFoodSpotsPage({super.key});

  final HomeController controller = Get.find<HomeController>();

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
          'Popular Food Spots',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: context.theme.brightness == Brightness.dark
                    ? AppColors.darkBackgroundColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: context.theme.brightness == Brightness.dark
                      ? Colors.white10
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for hot & new restaurants',
                        hintStyle: GoogleFonts.manrope(
                          color: Colors.grey[400],
                          fontSize: 13.sp,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.tune,
                      color: context.theme.brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Horizontal Chips
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                bool isSelected = index == 0;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : (context.theme.brightness == Brightness.dark
                            ? AppColors.darkSurfaceColor
                            : Colors.white),
                    borderRadius: BorderRadius.circular(20.r),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: context.theme.brightness == Brightness.dark
                                ? Colors.white10
                                : Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          category.imagePath,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.fastfood, size: 20),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category.title,
                        style: GoogleFonts.manrope(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : (context.theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : context.theme.textTheme.bodyLarge?.color),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Vertical List of Large Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Get.to(() => RestaurantDetailsPage()),
                  child: _buildLargeRestaurantCard(
                    context,
                    name: index == 0 ? 'The North Spoon' : 'The Southern Spoon',
                    location: 'Johannesburg',
                    price: r'$$$',
                    rating: 4.9,
                    imagePath: index == 0
                        ? 'assets/images/restaurent.png'
                        : 'assets/images/nearbyresturants.png',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeRestaurantCard(
    BuildContext context, {
    required String name,
    required String location,
    required String price,
    required double rating,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  imagePath,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 200.h, color: Colors.grey[200]),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: context.theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: context.theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$location · $price',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

