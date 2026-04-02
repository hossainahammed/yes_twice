import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import '../controllers/home_controller.dart';

class BrowseByFoodPage extends StatelessWidget {
  BrowseByFoodPage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Browse By Food',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for hot & new restaurants',
                        hintStyle: GoogleFonts.manrope(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    width: 1.w,
                    height: 24.h,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Icon(
                      Icons.tune,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Browse By Food',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 2.2,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                bool isSelected = index == 0; // Mocking selection for demo

                return Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4E070C) : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 4.w),
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            category.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.fastfood, size: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          category.title,
                          style: GoogleFonts.manrope(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
