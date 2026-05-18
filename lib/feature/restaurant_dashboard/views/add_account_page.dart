import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/widgets/success_dialog.dart';

class AddAccountPage extends StatefulWidget {
  final bool isEditMode;
  const AddAccountPage({super.key, this.isEditMode = false});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cuisineController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      nameController.text = "The Golden Plate";
      countryController.text = "United States";
      locationController.text = "123 Main St, New York, NY";
      cuisineController.text = "Italian";
      descController.text = "A fine dining experience offering authentic Italian cuisine with a modern twist.";
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    locationController.dispose();
    cuisineController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }

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
                  _buildTextField(
                    icon: Icons.store_outlined,
                    hint: "Enter Restaurant Name",
                    controller: nameController,
                  ),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Country"),
                  _buildTextField(
                    icon: Icons.public_outlined,
                    hint: "Enter Country",
                    controller: countryController,
                    suffixIcon: Icons.keyboard_arrow_down,
                  ),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Location"),
                  _buildTextField(
                    icon: Icons.location_on_outlined,
                    hint: "Enter address or drop pin on map",
                    controller: locationController,
                    suffixIcon: Icons.map_outlined,
                    suffixIconColor: const Color(0xFF4C080C),
                  ),
                  SizedBox(height: 20.h),
                  _buildFieldLabel("Cuisine"),
                  _buildTextField(
                    icon: Icons.restaurant_outlined,
                    hint: "Select cuisine type",
                    controller: cuisineController,
                    suffixIcon: Icons.keyboard_arrow_down,
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    icon: Icons.description_outlined,
                    hint: "Add description....",
                    controller: descController,
                    maxLines: 5,
                    height: 120.h,
                  ),
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
            widget.isEditMode ? "Edit Restaurant" : "Add Restaurant",
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

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    IconData? suffixIcon,
    Color? suffixIconColor,
    int maxLines = 1,
    double? height,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.manrope(
          color: Get.theme.textTheme.bodyLarge?.color,
          fontSize: 13.sp,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.manrope(color: Colors.grey.shade300, fontSize: 13.sp),
          prefixIcon: Padding(
            padding: EdgeInsets.only(bottom: maxLines > 1 ? 60.h : 0),
            child: Icon(icon, color: Colors.grey.shade400, size: 20.sp),
          ),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: suffixIconColor ?? Colors.grey.shade400, size: 20.sp)
              : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSmallPhoto(ImagePath.popularDishes1),
          SizedBox(width: 12.w),
          _buildSmallPhoto(ImagePath.popularDishes2),
          SizedBox(width: 12.w),
          ..._selectedImages.map((file) {
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  file,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          _buildAddPhotoButton(),
        ],
      ),
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
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
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
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SuccessDialog.show(
          title: widget.isEditMode ? "Restaurant updated" : "Restaurant added",
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
            widget.isEditMode ? "Update Restaurant" : "Add Restaurant",
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
