import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/app_colors.dart';

class AddEventPage extends StatefulWidget {
  final Map<String, dynamic>? eventData;
  final bool isEdit;
  const AddEventPage({super.key, this.eventData, this.isEdit = false});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.eventData != null) {
      _nameController.text = widget.eventData!['name'] ?? "";
      _venueController.text = widget.eventData!['venue'] ?? "";
      _dateController.text = widget.eventData!['date'] ?? "";
      _timeController.text = widget.eventData!['time'] ?? "";
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _nameController.dispose();
    _venueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              border: Border.all(color: Get.theme.dividerColor),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_left,
              color: Get.theme.iconTheme.color,
              size: 24.sp,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.isEdit ? "Edit Event" : "Add Event",
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Event Name"),
            _buildInputField(Icons.badge_outlined, "Enter Event Name", controller: _nameController),
            SizedBox(height: 20.h),
            _buildFieldLabel("Venue"),
            _buildInputFieldWithSuffix(
              Icons.location_on_outlined,
              "Enter address or drop pin on map",
              Icons.map_outlined,
              controller: _venueController,
            ),
            SizedBox(height: 20.h),
            _buildFieldLabel("Date"),
            _buildInputFieldWithSuffix(
              Icons.calendar_today_outlined,
              "Select Date",
              Icons.keyboard_arrow_down,
              controller: _dateController,
              readOnly: true,
              onTap: _pickDate,
            ),
            SizedBox(height: 20.h),
            _buildFieldLabel("Time"),
            _buildInputFieldWithSuffix(
              Icons.access_time,
              "Select Time",
              Icons.keyboard_arrow_down,
              controller: _timeController,
              readOnly: true,
              onTap: _pickTime,
            ),
            SizedBox(height: 20.h),
            _buildFieldLabel("Optional tag"),
            _buildInputField(
              Icons.style_outlined,
              "Enter tag and press return",
            ),
            SizedBox(height: 12.h),
            _buildTagPills(),
            SizedBox(height: 24.h),
            _buildDescriptionArea(),
            SizedBox(height: 32.h),
            Text(
              "Add Media",
              style: GoogleFonts.manrope(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Get.theme.textTheme.bodyLarge?.color,
              ),
            ),
            Text(
              "For event cover photo or gallery",
              style: GoogleFonts.manrope(
                fontSize: 12.sp,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 16.h),
            _buildPhotoGrid(),
            SizedBox(height: 48.h),
            _buildAddEventButton(),
            SizedBox(height: 24.h),
          ],
        ),
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
          color: Get.theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildInputField(IconData prefix, String hint, {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix, color: Colors.grey.shade400, size: 20.sp),
        hintText: hint,
        hintStyle: GoogleFonts.manrope(
          color: Colors.grey.shade400,
          fontSize: 13.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildInputFieldWithSuffix(
    IconData prefix,
    String hint,
    IconData suffix, {
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix, color: Colors.grey.shade400, size: 20.sp),
        suffixIcon: Icon(suffix, color: Get.theme.iconTheme.color, size: 20.sp),
        hintText: hint,
        hintStyle: GoogleFonts.manrope(
          color: Colors.grey.shade400,
          fontSize: 13.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Get.theme.dividerColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildTagPills() {
    return Wrap(
      spacing: 8.w,
      children: [
        _buildTag("Event"),
        _buildTag("Eating Food"),
        _buildTag("Flavor Street"),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Get.theme.brightness == Brightness.dark
            ? const Color(0xFF381B1B)
            : const Color(0xFFFFF2EF),
        borderRadius: BorderRadius.circular(8.r),
        // border: Border.all(color: AppColors.greyColor),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 11.sp,
          color: Get.theme.brightness == Brightness.dark
              ? AppColors.whiteColor
              : const Color(0xFFA12C05),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDescriptionArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: TextField(
        maxLines: 5,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(bottom: 70.h),
            child: Icon(
              Icons.email_outlined,
              color: Colors.grey.shade400,
              size: 20.sp,
            ),
          ),
          hintText: "Add description...",
          hintStyle: GoogleFonts.manrope(
            color: Colors.grey.shade400,
            fontSize: 13.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return Row(
      children: [
        _buildPhotoItem(ImagePath.event),
        SizedBox(width: 12.w),
        _buildPhotoItem(ImagePath.gallery1),
        SizedBox(width: 12.w),
        if (_selectedImage != null)
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(_selectedImage!, width: 80.w, height: 80.w, fit: BoxFit.cover),
            ),
          ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.grey.shade500,
                  size: 24.sp,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Add Media",
                  style: GoogleFonts.manrope(
                    fontSize: 10.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoItem(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.asset(image, width: 80.w, height: 80.w, fit: BoxFit.cover),
    );
  }

  Widget _buildAddEventButton() {
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
        child: Text(
          "Add Event",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Get.theme.brightness == Brightness.dark
                ? AppColors.whiteColor
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
