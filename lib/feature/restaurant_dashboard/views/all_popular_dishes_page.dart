import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import 'add_dish_page.dart';
import 'dish_details_page.dart';
import '../controllers/restaurant_dashboard_controller.dart';

class AllPopularDishesPage extends StatelessWidget {
  AllPopularDishesPage({super.key});

  final RestaurantDashboardController controller =
      Get.find<RestaurantDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 8,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          String image;
          String name;
          if (index % 3 == 0) {
            image = ImagePath.popularDishes1;
            name = "Truffle Tagliatelle";
          } else if (index % 3 == 1) {
            image = ImagePath.popularDishes2;
            name = "Chinese Special";
          } else {
            image = ImagePath.popularDishes3;
            name = "Classic Burger";
          }
          return _buildDishCard(context, name, "4.8", "(1220)", image);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: controller.currentNavIndex.value == 1
          ? null
          : IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: context.theme.iconTheme.color,
                size: 24.sp,
              ),
              onPressed: () => Get.back(),
            ),
      title: Text(
        "All Dishes", // All Popular Dishes
        style: GoogleFonts.manrope(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: context.theme.textTheme.bodyMedium?.color,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: GestureDetector(
            onTap: () => Get.to(() => const AddDishPage()),
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: context.theme.brightness == Brightness.dark
                    ? AppColors.primaryColor
                    : const Color(0xFF4C080C),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 20.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDishCard(
    BuildContext context,
    String name,
    String rating,
    String totalReviews,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () => Get.to(() => DishDetailsPage(
            name: name,
            rating: rating,
            totalReviews: totalReviews,
            imagePath: imagePath,
          )),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.greyColor),
        ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              imagePath,
              width: 60.w,
              height: 60.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Image.asset(ImagePath.rating, width: 12.w, height: 12.w),
                    SizedBox(width: 4.w),
                    Text(
                      rating,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      totalReviews,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showActionMenu(context, name: name, image: imagePath),
            icon: Icon(Icons.more_vert, color: const Color(0xFF101828), size: 20.sp),
          ),
        ],
      ),
    ),
    );
  }
  void _showActionMenu(BuildContext context, {String? name, String? image}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          width: 250.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem("Edit", () {
                Get.back();
                Get.to(() => AddDishPage(
                      isEdit: true,
                      dishData: {
                        'name': name,
                        'image': image,
                        'price': "\$ 12.00", // Mocked price
                      },
                    ));
              }),
              SizedBox(height: 20.h),
              _buildMenuItem("Delete", () {
                Get.back();
              }),
              SizedBox(height: 35.h),
              Obx(
                () => _buildToggleItem(
                  "ACTIVE",
                  controller.isActive.value,
                  const Color(0xFFA12C05),
                  (val) => controller.isActive.value = val,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildToggleItem(
                  "HIDE",
                  controller.isHide.value,
                  const Color(0xFF90A1B9),
                  (val) => controller.isHide.value = val,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: Get.theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem(
    String label,
    bool value,
    Color activeColor,
    Function(bool) onChanged,
  ) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              activeTrackColor: activeColor.withOpacity(0.2),
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade100,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: activeColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
