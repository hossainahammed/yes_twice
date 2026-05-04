import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class AllReviewsPage extends StatefulWidget {
  const AllReviewsPage({super.key});

  @override
  State<AllReviewsPage> createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  String _selectedSort = 'Recommended';
  double _minRating = 4.0;
  final Set<int> _expandedReplies = {};

  void _toggleReplies(int index) {
    setState(() {
      if (_expandedReplies.contains(index)) {
        _expandedReplies.remove(index);
      } else {
        _expandedReplies.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const CustomBackButton(),
        ),
        title: Text(
          'All Review',
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Reviews',
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: context.theme.textTheme.bodyLarge?.color,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showFilterBottomSheet(),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.tune,
                      color: context.theme.brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildReviewList(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
      itemBuilder: (context, index) {
        return _buildReviewCard(index, index == 0); // index 0 has images
      },
    );
  }

  Widget _buildReviewCard(int index, bool hasMedia) {
    final showResponse = _expandedReplies.contains(index);
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    'assets/images/recentViewCard.png',
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50.w,
                      height: 50.w,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kurt Bates',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: context.theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < 4
                                    ? Colors.orange
                                    : Colors.grey[200],
                                size: 14.sp,
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod.',
                        style: GoogleFonts.manrope(
                          fontSize: 11.sp,
                          color: context.theme.textTheme.bodyLarge?.color,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (hasMedia) ...[
            Padding(
              padding: EdgeInsets.all(8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  'assets/images/nearbyresturants.png',
                  width: double.infinity,
                  height: 140.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 140.h, color: Colors.grey[200]),
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _toggleReplies(index),
                  child: Row(
                    children: [
                      Text(
                        showResponse ? 'Hide replies' : 'View 1 replies',
                        style: GoogleFonts.manrope(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        showResponse
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showResponse) ...[
            Padding(
              padding: EdgeInsets.all(8.w),
              child: _buildRestaurantResponse(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRestaurantResponse() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 32.w),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            'assets/images/restaurent.png',
            width: 24.w,
            height: 24.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(width: 24.w, height: 24.h, color: Colors.grey[200]),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SMOKE HOUSE',
                style: GoogleFonts.manrope(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: context.theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod.',
                style: GoogleFonts.manrope(
                  fontSize: 10.sp,
                  color: Colors.grey[500],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 32.h),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
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
                        color: context.theme.dividerColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Filter',
                    style: GoogleFonts.manrope(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'SORT BY',
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildSortOption('Recommended', setModalState),
                  _buildSortOption('Rating (High to Low)', setModalState),
                  _buildSortOption('Review (High to Low)', setModalState),
                  SizedBox(height: 24.h),
                  Text(
                    'MINIMUM RATING',
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildRatingLevelSelector(setModalState),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedSort = 'Recommended';
                              _minRating = 4.0;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: Size(double.infinity, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: Text(
                            'Apply Filters',
                            style: GoogleFonts.manrope(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.brightnessOf(context) == Brightness.dark
                                  ? Colors.white
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSortOption(String title, StateSetter setModalState) {
    final isSelected = _selectedSort == title;
    return GestureDetector(
      onTap: () {
        setModalState(() {
          _selectedSort = title;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? context.theme.textTheme.bodyLarge?.color
                    : Colors.grey[600],
              ),
            ),
            Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey[300]!,
                  width: isSelected ? 5 : 1,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingLevelSelector(StateSetter setModalState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setModalState(() {
                  _minRating = index + 1.0;
                });
              },
              child: Icon(
                Icons.star_rounded,
                color: index < _minRating
                    ? AppColors.primaryColor
                    : Colors.grey[300],
                size: 24.sp,
              ),
            );
          }),
        ),
        Text(
          '$_minRating & Up',
          style: GoogleFonts.manrope(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
