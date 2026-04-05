import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/image_path.dart';
import '../controllers/restaurant_dashboard_controller.dart';
import 'gallery_page.dart';

class UploadGalleryPage extends StatelessWidget {
  UploadGalleryPage({super.key});

  final RestaurantDashboardController controller = Get.find<RestaurantDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Upload Gallery",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildDashedUploadArea(),
            SizedBox(height: 32.h),
            _buildUploadButton(),
            SizedBox(height: 40.h),
            _buildRecentUploadsHeader(),
            SizedBox(height: 20.h),
            _buildRecentUploadsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDashedUploadArea() {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
          style: BorderStyle.solid, // Fallback for dashed
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2EF),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_enhance_outlined, color: const Color(0xFFA12C05), size: 30.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              "Tap to upload photos/\nVideo",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "High-resolution assets make your restaurant stand\nout. Supports JPG,PNG,mp4 video",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 11.sp,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Upload Now",
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Icon(Icons.image_outlined, color: Colors.white, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildRecentUploadsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Recent Uploads",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => GalleryPage()),
          child: Text(
            "View All",
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentUploadsGrid(BuildContext context) {
    return GridView.builder(
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
        String image = index == 0 ? ImagePath.gallery1 : ImagePath.gallery2;
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(image, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
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
                  child: Icon(Icons.more_vert, color: Colors.black87, size: 16.sp),
                ),
              ),
            ),
          ],
        );
      },
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
