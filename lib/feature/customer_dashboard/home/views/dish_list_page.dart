import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'dish_details_page.dart';
import 'review_page.dart';

class DishListPage extends StatelessWidget {
  const DishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dishes = [
      {'name': 'Pizza', 'image': 'assets/images/pizza.png', 'rating': '4.9'},
      {'name': 'Chinese', 'image': 'assets/images/restaurent.png', 'rating': '4.9'},
      {'name': 'Burgers', 'image': 'assets/images/burger.png', 'rating': '4.9'},
      {'name': 'Pasta', 'image': 'assets/images/popularFoodSpots.png', 'rating': '4.8'},
      {'name': 'Salad', 'image': 'assets/images/nearbyresturants.png', 'rating': '4.7'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const CustomBackButton(),
        ),
        title: Text(
          'Dishes list',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: dishes.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return GestureDetector(
            onTap: () => Get.to(() => const DishDetailsPage()),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                      dish['image']!,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(width: 80.w, height: 80.h, color: Colors.grey[200]),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish['name']!,
                          style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(
                              dish['rating']!,
                              style: GoogleFonts.manrope(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '(450)',
                              style: GoogleFonts.manrope(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '\$\$\$',
                          style: GoogleFonts.manrope(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ReviewPage(
                      name: dish['name']!,
                      rating: dish['rating']!,
                      imagePath: dish['image']!,
                    )),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Text(
                        'Leave Review',
                        style: GoogleFonts.manrope(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
