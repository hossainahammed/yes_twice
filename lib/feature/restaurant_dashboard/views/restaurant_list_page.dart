import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/image_path.dart';
import 'delete_restaurant_page.dart';

class RestaurantListPage extends StatelessWidget {
  final bool isForDelete;
  const RestaurantListPage({super.key, this.isForDelete = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _buildRestaurantCard(context, "Smokehouse", "108 Oakway Lane, CA 91303", "\$\$", ImagePath.popularDishes1),
                SizedBox(height: 16.h),
                _buildRestaurantCard(context, "Shahjhan Grill", "3523 West Park SUMT 90001", "\$\$", ImagePath.popularDishes2),
                SizedBox(height: 16.h),
                _buildRestaurantCard(context, "Ramada", "1405 Mattson, IR 7103", "\$\$", ImagePath.popularDishes3),
                SizedBox(height: 16.h),
                _buildRestaurantCard(context, "HolidayInn", "2323 Dancing, NY 11101", "\$\$", ImagePath.gallery1),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: _buildAddButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
            isForDelete ? "Delete Restaurant" : "Restaurant list",
            style: GoogleFonts.manrope(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, String name, String address, String price, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (isForDelete) {
          Get.to(() => const DeleteRestaurantPage());
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                imagePath,
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: const Color(0xFF4C080C), size: 12.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          "$address · $price",
                          style: GoogleFonts.manrope(
                            fontSize: 11.sp,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4C080C),
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
}
