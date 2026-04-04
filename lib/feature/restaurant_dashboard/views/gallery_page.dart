import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../controllers/restaurant_dashboard_controller.dart';

class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});

  final RestaurantDashboardController controller = Get.find<RestaurantDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: _buildAppBar(context),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          String image = index % 2 == 0 ? ImagePath.gallery1 : ImagePath.gallery2;
          return _buildGalleryItem(context, image);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: controller.currentNavIndex.value == 3 
          ? null 
          : IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
              onPressed: () => Get.back(),
            ),
      title: Text(
        "Gallery",
        style: GoogleFonts.manrope(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4C080C),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryItem(BuildContext context, String imagePath) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.asset(
            imagePath,
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
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert,
                color: Colors.black87,
                size: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showActionMenu(BuildContext context) {
    Get.dialog(
      Dialog(
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
            color: Colors.black,
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
