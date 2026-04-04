import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/image_path.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Review",
          style: GoogleFonts.manrope(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 150.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReviewsFeedHeader(),
                SizedBox(height: 20.h),
                _buildFilters(),
                SizedBox(height: 24.h),
                _buildReviewItem(
                  "Julianne Doe",
                  "2 HOURS AGO",
                  "The \"Spicy Miso Ramen\" was absolute perfection! The broth had such a deep, rich flavor and the egg was marinated beautifully. Definitely coming back.",
                  5,
                  [ImagePath.popularDishes1, ImagePath.gallery2],
                  true,
                ),
                SizedBox(height: 20.h),
                _buildReviewItem(
                  "Mark Smith",
                  "YESTERDAY",
                  "\"Good service, but the waiting time was a bit longer than expected for a Tuesday night.\"",
                  3,
                  [],
                  false,
                ),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildReplySection()),
        ],
      ),
    );
  }

  Widget _buildReviewsFeedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reviews Feed",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2EF),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 14.sp),
              SizedBox(width: 4.w),
              Text(
                "4.8",
                style: GoogleFonts.manrope(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip("All", true),
          SizedBox(width: 12.w),
          _buildFilterChip("5 Stars", false),
          SizedBox(width: 12.w),
          _buildFilterChip("4 Stars", false),
          SizedBox(width: 12.w),
          _buildFilterChip("3 Stars", false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4C080C) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade200,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _buildReviewItem(
    String name,
    String time,
    String content,
    int rating,
    List<String> images,
    bool isHighlighted,
  ) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: AssetImage(ImagePath.reviewAvatar),
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
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 12.sp,
                          color: index < rating
                              ? Colors.orange
                              : Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: GoogleFonts.manrope(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            content,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          if (images.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Row(
              children: images
                  .map(
                    (img) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          img,
                          width: 80.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: isHighlighted,
                      onChanged: (val) {},
                      activeColor: const Color(0xFFA12C05),
                    ),
                  ),
                  Text(
                    "HIGHLIGHT",
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2EF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply,
                      color: const Color(0xFFA12C05),
                      size: 14.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Reply",
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFA12C05),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplySection() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 40.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reply Message",
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  "Describe the flavors, ingredients, and soul of the dish...",
              hintStyle: GoogleFonts.manrope(
                color: Colors.grey.shade400,
                fontSize: 12.sp,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4C080C),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                "Send",
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
