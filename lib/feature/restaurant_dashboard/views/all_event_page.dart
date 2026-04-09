import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import 'add_event_page.dart';
import '../controllers/restaurant_dashboard_controller.dart';

class AllEventPage extends StatelessWidget {
  final bool? forceEmpty;
  const AllEventPage({super.key, this.forceEmpty});

  RestaurantDashboardController get controller =>
      Get.find<RestaurantDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: Obx(() {
        bool showEmpty = forceEmpty ?? (controller.events.isEmpty);
        return showEmpty
            ? _buildEmptyState()
            : ListView.separated(
                padding: EdgeInsets.all(20.w),
                itemCount: controller.events.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _buildEventCard(context);
                },
              );
      }),
      bottomNavigationBar: Obx(() {
        bool showEmpty = forceEmpty ?? (controller.events.isEmpty);
        return showEmpty
            ? Padding(
                padding: EdgeInsets.all(20.w),
                child: _buildAddRestaurantButton(),
              )
            : const SizedBox.shrink();
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Center(
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
      ),
      title: Text(
        "All Events",
        style: GoogleFonts.manrope(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Get.theme.textTheme.bodyMedium?.color,
        ),
      ),
      actions: [
        Obx(() {
          if (controller.events.isNotEmpty && forceEmpty != true) {
            return Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () => Get.to(() => const AddEventPage()),
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Get.theme.brightness == Brightness.dark
                        ? AppColors.primaryColor
                        : const Color(0xFF4C080C),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            ImagePath.emptyeventList,
            width: 140.w,
            height: 140.w,
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          "Nothing here yet.\nGo explore!",
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: Get.theme.textTheme.bodyMedium?.color,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildAddRestaurantButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Get.theme.brightness == Brightness.dark
            ? AppColors.primaryColor
            : const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Add Restaurant",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return Container(
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
                      color: Colors.black,
                      size: 11.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "21 July, 2025 | 11:30 pm",
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.greyColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                      size: 11.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "123 Foodie Lane, Joha...",
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.greyColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showActionMenu(context),
            icon: Icon(Icons.more_vert, color: Colors.black, size: 20.sp),
          ),
        ],
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
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
}
