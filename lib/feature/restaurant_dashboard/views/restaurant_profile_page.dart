import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'add_account_page.dart';
import 'restaurant_list_page.dart';
import '../../../../core/constant/image_path.dart';

class RestaurantProfilePage extends StatelessWidget {
  const RestaurantProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                SizedBox(height: 24.h),
                _buildGeneralInfoSection(),
                SizedBox(height: 24.h),
                _buildDetailsSection(),
                SizedBox(height: 24.h),
                _buildLocationContactSection(),
                SizedBox(height: 40.h),
                _buildSaveButton(),
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
      padding: EdgeInsets.fromLTRB(20.w, 50.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(ImagePath.dashboardProfile),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back ,",
                  style: GoogleFonts.manrope(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Text(
                  "The Rustic Bistro",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showAccountBottomSheet(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Restaurant Profile"),
        SizedBox(height: 12.h),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                ImagePath.popularDishes1,
                width: double.infinity,
                height: 150.h,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 12.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9663A),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGeneralInfoSection() {
    return _buildContainer(
      column: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("General Information"),
          SizedBox(height: 16.h),
          _buildFieldLabel("Restaurant Name"),
          _buildTextField("The Rustic Grill"),
          SizedBox(height: 20.h),
          _buildFieldLabel("Description"),
          _buildTextArea(
            "Expeience authentic wood-fired grilling with locally sourced ingredients. A cozy atmosphere perfect for family dinners and date nights.",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return _buildContainer(
      column: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Details"),
          SizedBox(height: 16.h),
          _buildFieldLabel("Cuisine Type"),
          Wrap(
            spacing: 8.w,
            children: [
              _buildChip("American", true),
              _buildChip("BBQ", true),
              _buildChip("Add", false),
            ],
          ),
          SizedBox(height: 20.h),
          _buildFieldLabel("Price Range"),
          Row(
            children: [
              _buildPriceOption("\$", false),
              _buildPriceOption("\$\$", true),
              _buildPriceOption("\$\$\$", false),
            ],
          ),
          SizedBox(height: 20.h),
          _buildFieldLabel("Business Hours"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHourSelect("11:00 AM"),
              Icon(
                Icons.access_time,
                color: const Color(0xFFF9663A),
                size: 20.sp,
              ),
              _buildHourSelect("11:00 PM"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationContactSection() {
    return _buildContainer(
      column: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Location & Contact"),
          SizedBox(height: 16.h),
          _buildFieldLabel("Address"),
          _buildIconTextField(
            Icons.location_on_outlined,
            "123 Main St, Portland, OR 97204",
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors
                    .grey
                    .shade200, // Slightly darker to distinguish from white
                image: DecorationImage(
                  image: AssetImage(ImagePath.map),
                  fit: BoxFit.cover, // Ensures the map fills the area
                ),
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      color: Colors.grey.shade300,
                      size: 80.sp,
                    ),
                    Icon(
                      Icons.location_on,
                      color: const Color(0xFFF9663A),
                      size: 30.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildFieldLabel("Phone Number"),
          _buildIconTextField(Icons.phone_outlined, "(555) 123-4567"),
        ],
      ),
    );
  }

  Widget _buildContainer({required Widget column}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: column,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 13.sp,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildTextField(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(color: Colors.black87, fontSize: 13.sp),
      ),
    );
  }

  Widget _buildIconTextField(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            text,
            style: GoogleFonts.manrope(color: Colors.black87, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          color: Colors.black87,
          fontSize: 13.sp,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool canDelete) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2EF),
        borderRadius: BorderRadius.circular(25.r),
        border: !canDelete
            ? Border.all(color: Colors.grey.shade300, style: BorderStyle.solid)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!canDelete)
            Icon(Icons.add, color: Colors.grey.shade400, size: 14.sp),
          SizedBox(width: !canDelete ? 4.w : 0),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12.sp,
              color: canDelete ? const Color(0xFFA12C05) : Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (canDelete) ...[
            SizedBox(width: 4.w),
            Icon(Icons.close, color: const Color(0xFFA12C05), size: 14.sp),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceOption(String label, bool isSelected) {
    return Expanded(
      child: Container(
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFFFF2EF),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHourSelect(String time) {
    return Container(
      width: 120.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2EF),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(
          time,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Text(
          "Save",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showAccountBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildAccountSwitchItem(
                    ImagePath.dashboardProfile,
                    "The Rustic Bistro",
                    true,
                    () => Get.back(),
                  ),
                  SizedBox(height: 12.h),
                  _buildAddAccountItem(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Your Another Profile",
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            _buildAccountSwitchItem(
              ImagePath.popularDishes1,
              "The Rustic Bistro",
              false,
              () => Get.to(() => RestaurantListPage()),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildAccountSwitchItem(
    String imagePath,
    String name,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 18.r, backgroundImage: AssetImage(imagePath)),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.manrope(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF4C080C),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAccountItem() {
    return GestureDetector(
      onTap: () => Get.to(() => const AddAccountPage()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(Icons.add, color: Colors.black, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              "Add Another Account",
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
