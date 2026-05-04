import 'package:bolaji277/core/service/auth_service.dart';
import '../../../auth/login/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart'; // For CustomBackButton
import '../controllers/save_controller.dart';
import '../../home/views/restaurant_details_page.dart';
import '../../home/views/event_details_page.dart';
import '../../home/views/dish_details_page.dart';

class SavePage extends StatelessWidget {
  SavePage({super.key});

  final SaveController controller = Get.put(SaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Saved',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      body: Obx(() {
        if (AuthService.to.isGuest) {
          return _buildGuestAccessPrompt(context);
        }
        return Column(
          children: [
            const SizedBox(height: 16),
            _buildTabs(context),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                int index = controller.selectedTabIndex.value;
                List<SavedItem> items = [];
                if (index == 0)
                  items = controller.savedRestaurants;
                else if (index == 1)
                  items = controller.savedFoods;
                else
                  items = controller.savedEvents;

                if (items.isEmpty) {
                  return _buildEmptyState(context);
                }

                if (index == 0) {
                  return _buildRestaurantGrid(context, items);
                } else if (index == 1) {
                  return _buildFoodList(items);
                } else {
                  return _buildEventGrid(context, items);
                }
              }),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(3, (index) {
          return Obx(() {
            bool isSelected = controller.selectedTabIndex.value == index;
            return GestureDetector(
              onTap: () => controller.switchTab(index),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.brightnessOf(context) == Brightness.dark
                            ? AppColors.primaryColor
                            : AppColors.primaryColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Theme.of(context).dividerColor,
                  ),
                ),
                child: Text(
                  controller.tabs[index],
                  style: GoogleFonts.manrope(
                    color: isSelected
                        ? Theme.brightnessOf(context) == Brightness.dark
                              ? Colors.white
                              : Colors.white
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.bookmark,
                size: 100,
                color: AppColors.primaryColor,
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "You haven't saved\nanything yet!",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantGrid(BuildContext context, List<SavedItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        final item = items[index];
        return _buildGridCard(context, item, isRestaurant: true);
      },
    );
  }

  Widget _buildEventGrid(BuildContext context, List<SavedItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        final item = items[index];
        return _buildGridCard(context, item, isRestaurant: false);
      },
    );
  }

  Widget _buildGridCard(
    BuildContext context,
    SavedItem item, {
    required bool isRestaurant,
  }) {
    return GestureDetector(
      onTap: () {
        if (isRestaurant) {
          Get.to(() => const RestaurantDetailsPage());
        } else {
          Get.to(() => const EventDetailsPage());
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.asset(
                      item.imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[200]),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
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
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.rating.toString(),
                            style: GoogleFonts.manrope(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primaryColor,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                      if (isRestaurant && item.priceOrCategory.isNotEmpty)
                        Text(
                          '  ${item.priceOrCategory}',
                          style: GoogleFonts.manrope(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodList(List<SavedItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => Get.to(() => const DishDetailsPage()),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.05),
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
                    item.imagePath,
                    height: 80.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 80.h,
                      width: 80.w,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.rating.toString(),
                            style: GoogleFonts.manrope(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${item.reviews})',
                            style: GoogleFonts.manrope(
                              color: Colors.grey,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                            item.priceOrCategory,
                            style: GoogleFonts.manrope(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Quick View',
                        style: GoogleFonts.manrope(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGuestAccessPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                size: 60,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Sign in to save items',
              style: GoogleFonts.manrope(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Bookmarks help you keep track of your favorite restaurants, dishes, and events.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Get.offAll(() => const LoginPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'Sign In Now',
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
    );
  }
}
