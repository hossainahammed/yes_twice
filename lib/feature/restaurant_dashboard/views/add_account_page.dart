import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/widgets/success_dialog.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel("Restaurant Name"),
                  _buildIconTextField(Icons.store_outlined, "Enter Restaurant Name"),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Country"),
                  _buildDropdownField(Icons.public_outlined, "Enter Country"),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Location"),
                  _buildLocationField("Enter address or drop pin on map"),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Cuisine"),
                  _buildDropdownField(Icons.restaurant_outlined, "Select cuisine type"),
                  SizedBox(height: 20.h),
                  _buildTextArea(Icons.description_outlined, "Add description...."),
                  SizedBox(height: 24.h),
                  _buildSectionTitle("Add photos"),
                  Text(
                    "For restaurant cover photo or gallery",
                    style: GoogleFonts.manrope(
                      fontSize: 12.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildPhotoSelection(),
                  SizedBox(height: 40.h),
                  _buildAddButton(context),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 30.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
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
          Text(
            "Add Restaurant",
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Get.theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: Get.theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  Widget _buildIconTextField(IconData icon, String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Text(
            hint,
            style: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(IconData icon, String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildLocationField(String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
            ),
          ),
          Icon(Icons.map_outlined, color: const Color(0xFF4C080C), size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildTextArea(IconData icon, String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      height: 120.h,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Get.theme.textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildPhotoSelection() {
    return Row(
      children: [
        _buildSmallPhoto(ImagePath.popularDishes1),
        SizedBox(width: 12.w),
        _buildSmallPhoto(ImagePath.popularDishes2),
        SizedBox(width: 12.w),
        _buildAddPhotoButton(),
      ],
    );
  }

  Widget _buildSmallPhoto(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.asset(
        path,
        width: 60.w,
        height: 60.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Get.theme.dividerColor, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_photo_alternate_outlined, color: Colors.grey.shade400, size: 20.sp),
          SizedBox(height: 4.h),
          Text(
            "Add Media",
            style: GoogleFonts.manrope(
              fontSize: 8.sp,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SuccessDialog.show(
          title: "Restaurant added",
          context: context,
          onPressed: () {
            Get.back();
            Get.back();
          },
          iconPath: ImagePath.resturantAdd,
        );
      },
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: Get.theme.brightness == Brightness.dark ? AppColors.primaryColor : const Color(0xFF4C080C),
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
      ),
    );
  }
}
