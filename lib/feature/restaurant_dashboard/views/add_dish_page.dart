import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/app_colors.dart';

class AddDishPage extends StatelessWidget {
  const AddDishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Get.theme.iconTheme.color,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add New Dishes",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Item Photo",
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Get.theme.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: 12.h),
            _buildMainPhotoSelection(),
            SizedBox(height: 12.h),
            _buildThumbnailRow(),
            SizedBox(height: 24.h),
            _buildInputField("Food Name", "Truffle Tagliatelle"),
            SizedBox(height: 20.h),
            _buildDropdownField("Category", "Pasta"),
            SizedBox(height: 20.h),
            _buildInputField("Price", "\$ 0.00"),
            SizedBox(height: 20.h),
            _buildDescriptionField(
              "Description",
              "Describe the flavors, ingredients, and soul of the dish...",
            ),
            SizedBox(height: 40.h),
            _buildPublishButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMainPhotoSelection() {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        image: DecorationImage(
          image: AssetImage(ImagePath.popularDishes1),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30.sp),
            SizedBox(height: 8.h),
            Text(
              "Add Media", // UPLOAD DISHES PHOTO
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildThumbnailItem(ImagePath.popularDishes2),
        _buildThumbnailItem(ImagePath.popularDishes3),
        _buildThumbnailItem(ImagePath.popularDishes1),
        _buildSeeMoreThumbnail(ImagePath.popularDishes2, "See More\n6 Item"),
      ],
    );
  }

  Widget _buildThumbnailItem(String image) {
    return Container(
      width: 75.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Icon(Icons.close, color: Colors.white, size: 14.sp),
        ),
      ),
    );
  }

  Widget _buildSeeMoreThumbnail(String image, String text) {
    return Container(
      width: 75.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(color: Colors.grey, fontSize: 13.sp),
            filled: true,
            // fillColor: Get.theme.cardColor,
            fillColor: Get.theme.brightness == Brightness.dark
                ? Get.theme.cardColor
                : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Get.theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey.shade100,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Get.theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey.shade100,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            // color: Get.theme.cardColor,
            color: Get.theme.brightness == Brightness.dark
                ? Get.theme.cardColor
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Get.theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey.shade100,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.manrope(
                  color: Get.theme.textTheme.bodyMedium?.color,
                  fontSize: 13.sp,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Get.theme.iconTheme.color),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
              color: Colors.grey.shade400,
              fontSize: 13.sp,
            ),
            filled: true,
            fillColor: Get.theme.brightness == Brightness.dark
                ? Get.theme.cardColor
                : Colors.grey.shade100,
            // fillColor: Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Get.theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey.shade100,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Get.theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey.shade100,
              ),
            ),
            contentPadding: EdgeInsets.all(16.w),
          ),
        ),
      ],
    );
  }

  Widget _buildPublishButton() {
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Publish Item",
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Get.theme.brightness == Brightness.dark
                    ? AppColors.whiteColor
                    : Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.restaurant_menu,
              color: Get.theme.brightness == Brightness.dark
                  ? AppColors.primaryColor
                  : Colors.white,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
