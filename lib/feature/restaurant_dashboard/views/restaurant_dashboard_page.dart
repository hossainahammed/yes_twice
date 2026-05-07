import 'package:bolaji277/feature/restaurant_dashboard/views/add_dish_page.dart';
import 'package:bolaji277/feature/restaurant_dashboard/views/add_event_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../controllers/restaurant_dashboard_controller.dart';
import 'notification_page.dart';
import 'all_popular_dishes_page.dart';
import 'all_event_page.dart';
import 'gallery_page.dart';
import 'upload_gallery_page.dart';
import 'review_page.dart';
import 'dish_details_page.dart';
import 'event_details_page.dart';
import 'restaurant_profile_page.dart';
import 'settings_page.dart';

class RestaurantDashboardPage extends StatelessWidget {
  RestaurantDashboardPage({super.key});

  final RestaurantDashboardController controller = Get.put(
    RestaurantDashboardController(),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: Obx(() {
          switch (controller.currentNavIndex.value) {
            case 0:
              return _buildDashboardBody(context);
            case 1:
              return AllPopularDishesPage();
            case 2:
              return AllEventPage();
            case 3:
              return GalleryPage();
            case 4:
              return const SettingsPage();
            case 5:
              return const RestaurantProfilePage();
            default:
              return _buildDashboardBody(context);
          }
        }),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildDashboardBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildStatsGrid(),
                SizedBox(height: 20.h),
                _buildTotalViewsCard(),
                SizedBox(height: 24.h),
                _buildSectionTitle("Quick Actions"),
                SizedBox(height: 16.h),
                _buildQuickActions(),
                SizedBox(height: 24.h),
                _buildTabs(),
                SizedBox(height: 20.h),
                Obx(() {
                  bool showDishes = controller.selectedTab.value == 0;
                  bool showEvents = controller.selectedTab.value <= 1;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDishes) ...[
                        _buildDishesContent(context),
                        SizedBox(height: 24.h),
                      ],
                      if (showEvents) ...[
                        _buildEventContent(context),
                        SizedBox(height: 24.h),
                      ],
                      _buildGalleryContent(),
                    ],
                  );
                }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 35.h),
      decoration: BoxDecoration(
        color: Get.theme.brightness == Brightness.dark
            ? AppColors.primaryColor
            : AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.changeNavIndex(5),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                radius: 24.r,
                backgroundImage: AssetImage(ImagePath.dashboardProfile),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back ,",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "The Rustic Bistro",
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => const NotificationPage()),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Reviews",
            "152",
            null,
            Row(
              children: List.generate(
                5,
                (index) =>
                    Image.asset(ImagePath.rating, width: 10.w, height: 10.w),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildStatCard(
            "Avg Rating",
            "4.8",
            null,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle, // Success sign
                  color: (Get.theme.brightness == Brightness.dark
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor),
                  size: 14.sp,
                ),
                SizedBox(width: 4.w), // Space between icon and text
                Text(
                  "Top 5% in city",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: (Get.theme.brightness == Brightness.dark
                        ? AppColors.whiteColor
                        : AppColors.secondaryColor),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String mainValue,
    Widget? icon,
    Widget extra,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Get.theme.brightness == Brightness.dark
              ? Colors.white
              : AppColors.greyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: (Get.theme.brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.secondaryColor),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            mainValue,
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              color: Get.theme.textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          extra,
        ],
      ),
    );
  }

  Widget _buildTotalViewsCard() {
    return Container(
      width: double.infinity,

      //height: 120.h,
      // padding: EdgeInsets.all(18.w),
      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      padding: EdgeInsets.only(left: 20.w, right: 0.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        color: Get.theme.brightness == Brightness.dark
            ? AppColors.primaryColor
            : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -22.w,
            bottom: -28.h,
            // top: 5.h,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.visibility_outlined,
                size: 125.sp,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Views",
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    "2.4k",
                    style: GoogleFonts.manrope(
                      fontSize: 32.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "12%",
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: Get.theme.textTheme.bodyMedium?.color,
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(
          "Add Food",
          Icons.add_box_outlined,
          Colors.orange.shade50,
          Colors.orange,
          () => Get.to(() => AddDishPage()),
        ),
        _buildActionItem(
          "Add Event",
          Icons.event_outlined,
          //ImagePath.addEvent,
          Colors.purple.shade50,
          Colors.purple,
          () => Get.to(() => AddEventPage()),
        ),
        _buildActionItem(
          "Upload Gallery",
          Icons.add_a_photo_rounded,
          //ImagePath.uploadGallery,
          Colors.blue.shade50,
          Colors.blue,
          () => Get.to(() => UploadGalleryPage()),
        ),
      ],
    );
  }

  Widget _buildActionItem(
    String title,
    dynamic iconOrImage,
    Color bgColor,
    Color iconColor, [
    VoidCallback? onTap,
  ]) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Get.theme.dividerColor),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: iconOrImage is IconData
                    ? Icon(iconOrImage, color: iconColor, size: 24.sp)
                    : Image.asset(
                        iconOrImage,
                        width: 90.w,
                        height: 90.w,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Get.theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Obx(
      () => Row(
        children: [
          _buildTabButton("Dishes", 0),
          SizedBox(width: 12.w),
          _buildTabButton("Event", 1),
          SizedBox(width: 12.w),
          _buildTabButton("Gallery", 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (Get.theme.brightness == Brightness.dark
                    ? AppColors.primaryColor
                    : AppColors.primaryColor)
              : Get.theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.greyColor,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (Get.theme.brightness == Brightness.dark
                      ? Colors.grey.shade400
                      : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildDishesContent(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader("Popular Dishes", () {
          Get.to(() => AllPopularDishesPage());
        }),
        SizedBox(height: 16.h),
        _buildDishCard(
          context,
          "Truffle Tagliatelle",
          //"\$ 4.9",
          "4.9",
          " (1220)",
          ImagePath.popularDishes1,
        ),
        SizedBox(height: 16.h),
        _buildDishCard(
          context,
          "Chinese",
          "4.8",
          " (1220)",
          ImagePath.popularDishes2,
        ),
        SizedBox(height: 16.h),
        _buildDishCard(
          context,
          "Burgers",
          "4.8",
          " (1320)",
          ImagePath.popularDishes3,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(
                "View All",
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  color: (Get.theme.brightness == Brightness.dark
                      ? AppColors.whiteColor
                      : AppColors.secondaryColor),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: (Get.theme.brightness == Brightness.dark
                    ? AppColors.whiteColor
                    : AppColors.secondaryColor),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDishCard(
    BuildContext context,
    String name,
    String rating,
    String price,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DishDetailsPage(
              name: name,
              rating: rating,
              totalReviews: price,
              imagePath: imagePath,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
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
                    color: Get.theme.textTheme.bodyLarge?.color,
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
                        color: Get.theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      price,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showActionMenu(context),
            child: Icon(
              Icons.more_vert,
              color: Get.theme.brightness == Brightness.dark
                  ? Colors.grey.shade400
                  : Colors.black,
              size: 20.sp,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildEventContent(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader("Event", () {
          Get.to(() => AllEventPage());
        }),
        SizedBox(height: 16.h),
        _buildEventCard(context),
        SizedBox(height: 16.h),
        _buildEventCard(context),
        SizedBox(height: 16.h),
        _buildEventCard(context),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EventDetailsPage());
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              ImagePath.event,
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
                  "Sunset Jazz & Tapas",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Get.theme.brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black,
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "21 July, 2025 | 11:30 pm",
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.brightness == Brightness.dark
                            ? Colors.grey.shade400
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: AppColors.primaryColor,
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "123 Foodie Lane, JoPex...",
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.brightness == Brightness.dark
                            ? Colors.grey.shade400
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showActionMenu(context),
            child: Icon(
              Icons.more_vert,
              color: Get.theme.brightness == Brightness.dark
                  ? Colors.grey.shade400
                  : Colors.black,
              size: 20.sp,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildGalleryContent() {
    return Column(
      children: [
        _buildSectionHeader("Gallery", () {
          Get.to(() => GalleryPage());
        }),
        // SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => GalleryPage());
              },
              child: Stack(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    index == 0 ? ImagePath.gallery1 : ImagePath.gallery2,
                    // index == 1 ? ImagePath.gallery1 : ImagePath.gallery2,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.w,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: () => _showActionMenu(context),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Get.theme.cardColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: Get.theme.textTheme.bodyLarge?.color,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ));
          },
        ),
        SizedBox(height: 24.h),
        _buildSectionHeader("Recent Reviews", () {
          Get.to(() => const ReviewPage());
        }),
        SizedBox(height: 16.h),
        _buildReviewItem(),
        _buildReviewItem(),
        _buildReviewItem(),
      ],
    );
  }

  Widget _buildReviewItem() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              //color: Color(0xFF2C2C2C),
              color: AppColors.reviewBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.rate_review_outlined,
              color: Colors.red.shade800,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New 5-star review from Sarah",
                      style: GoogleFonts.manrope(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Get.theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      "2m ago",
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "\"Best pasta I've ever had in the city!\"",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
          width: 250.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem("Edit", () {
                Get.back();
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
            color: Get.theme.textTheme.bodyLarge?.color,
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

  Widget _buildBottomNav(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -5),
              blurRadius: 20,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value > 4
              ? 0
              : controller.currentNavIndex.value,
          onTap: controller.changeNavIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Get.theme.brightness == Brightness.dark
              ? AppColors.primaryColor
              : AppColors.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: GoogleFonts.manrope(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: GoogleFonts.manrope(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: "Dishes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              label: "Event",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined),
              label: "Gallery",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
