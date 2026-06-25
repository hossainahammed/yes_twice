import 'dart:io';

import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import 'profile_screen.dart';
import '../../../core/widgets/app_background.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final profileController = ProfileController.to;
    _nameController = TextEditingController(text: profileController.fullName.value);
    _emailController = TextEditingController(text: profileController.email.value);
    _phoneController = TextEditingController(text: profileController.phone.value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.to;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.lora(
                        fontSize: 20.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable Fields
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),

                      /// Profile Photo Avatar with Edit Badge
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: _selectedImage != null
                                        ? Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                      controller.avatarPath.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _showImageSourceBottomSheet,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to change photo',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFB3B5BA),
                                fontSize: 12.mq(context),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// Personal Information Form Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF101828,
                          ).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Personal information',
                              style: GoogleFonts.lora(
                                fontSize: 16.mq(context),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),

                            /// Full Name Field
                            _buildFormLabel('Full Name'),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hint: 'John Doe',
                              prefixIcon: Icons.person_outline,
                              controller: _nameController,
                            ),

                            const SizedBox(height: 18),

                            /// Email Address Field
                            _buildFormLabel('Email Address'),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hint: 'you@example.com',
                              prefixIcon: Icons.email_outlined,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 18),

                            /// Phone Number Field
                            _buildFormLabel('Phone Number'),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hint: '+971 50 123 4567',
                              prefixIcon: Icons.phone_outlined,
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// Save Change Button
                      ElevatedButton(
                        onPressed: () {
                          controller.saveChanges(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            imagePath: _selectedImage?.path,
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.save_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Save Change',
                              style: GoogleFonts.poppins(
                                fontSize: 14.mq(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: const BottomNavBar(activeIndex: 4),

      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101828),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Profile Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.white),
                  title: const Text(
                    'Take Photo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.white),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildFormLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 12.mq(context),
        fontWeight: FontWeight.w500,
        color: const Color(0xFFB3B5BA),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData prefixIcon,
    required TextEditingController controller,
    TextInputType? keyboardType,
    Widget? suffixWidget,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Icon(prefixIcon, color: Colors.grey.shade400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14.mq(context)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontSize: 14.mq(context),
                ),
              ),
            ),
          ),
          if (suffixWidget != null) suffixWidget,
        ],
      ),
    );
  }
}
