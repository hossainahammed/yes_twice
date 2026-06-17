import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.8),
            radius: 1.5,
            colors: [
              Color(0xFF2B1416), // Dark Red glow
              Color(0xFF080808), // Dark background
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              /// Top Progress Indicator Row (4 segments)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() => Row(
                      children: List.generate(controller.totalPages, (index) {
                        final isActive = index <= controller.currentPage.value;
                        return Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFFF7F7F)
                                  : Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    )),
              ),

              /// Skip Button (Top Right)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, top: 12),
                  child: GestureDetector(
                    onTap: controller.skip,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Skip',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFF7F7F),
                          fontSize: 14.mq(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// Page Content (PageView)
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.changePage,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildTrackJourneySlide(context, width, height),
                    _buildPersonalInfoSlide(context),
                    _buildSelectSportsSlide(context),
                    _buildChooseGoalsSlide(context),
                  ],
                ),
              ),

              /// Bottom Action Buttons
              Obx(() {
                final page = controller.currentPage.value;
                if (page == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: GoogleFonts.poppins(
                              fontSize: 14.mq(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.previousPage,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFF101828).withValues(alpha: 0.55),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.chevron_left, color: Colors.white, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14.mq(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.nextPage,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: Text(
                              page == 3 ? 'Get Started' : 'Next',
                              style: GoogleFonts.poppins(
                                fontSize: 14.mq(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Slide 1: Track Your Journey
  Widget _buildTrackJourneySlide(BuildContext context, double width, double height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: height * 0.12),

          /// Trophy Circle
          Container(
            width: 86,
            height: 86,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_outlined,
              color: AppColors.primaryColor,
              size: 44,
            ),
          ),

          SizedBox(height: height * 0.05),

          /// Heading
          Text(
            'Track Your Journey',
            textAlign: TextAlign.center,
            style: GoogleFonts.lora(
              fontSize: 26.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          /// Description
          Text(
            'Monitor training, recovery, and performance\nall in one place',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13.mq(context),
              fontWeight: FontWeight.w400,
              color: const Color(0xFFB3B5BA),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Slide 2: Personal Information
  Widget _buildPersonalInfoSlide(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Personal Information',
            style: GoogleFonts.lora(
              fontSize: 22.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          /// Age
          _buildFormLabel(context, 'Your Age'),
          const SizedBox(height: 8),
          _buildCustomInput(
            context,
            controller: controller.ageController,
            keyboardType: TextInputType.number,
            hintText: 'Enter your age',
          ),

          const SizedBox(height: 20),

          /// Height
          _buildFormLabel(context, 'Height'),
          const SizedBox(height: 8),
          Obx(() => _buildCustomInput(
                context,
                controller: controller.heightController,
                keyboardType: TextInputType.number,
                hintText: 'Enter height',
                suffixWidget: _buildUnitSelector(
                  context,
                  selectedLabel: 'Cm',
                  unselectedLabel: 'Inches',
                  isSelected: controller.isCm.value,
                  onChanged: (val) => controller.toggleHeightUnit(val),
                ),
              )),

          const SizedBox(height: 20),

          /// Weight
          _buildFormLabel(context, 'Weight'),
          const SizedBox(height: 8),
          Obx(() => _buildCustomInput(
                context,
                controller: controller.weightController,
                keyboardType: TextInputType.number,
                hintText: 'Enter weight',
                suffixWidget: _buildUnitSelector(
                  context,
                  selectedLabel: 'Kg',
                  unselectedLabel: 'Lbs',
                  isSelected: controller.isKg.value,
                  onChanged: (val) => controller.toggleWeightUnit(val),
                ),
              )),
        ],
      ),
    );
  }

  /// Slide 3: Select Your Sport
  Widget _buildSelectSportsSlide(BuildContext context) {
    final sports = [
      ['Football', 'Basketball'],
      ['Soccer', 'Tennis'],
      ['Running', 'Swimming'],
      ['Volleyball', 'Track & Field'],
      ['Other', ''],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Select Your Sport',
            style: GoogleFonts.lora(
              fontSize: 22.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          ...sports.map((pair) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSportButton(context, pair[0]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: pair[1].isNotEmpty
                        ? _buildSportButton(context, pair[1])
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Slide 4: Choose Your Goals
  Widget _buildChooseGoalsSlide(BuildContext context) {
    final goals = [
      'Improve Performance',
      'Build Endurance',
      'Prevent Injury',
      'Track Progress',
      'Stay Consistent',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Choose Your Goals (select multiple)',
            style: GoogleFonts.lora(
              fontSize: 22.mq(context),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          ...goals.map((goal) => _buildGoalCard(context, goal)),
        ],
      ),
    );
  }

  /// Helper Widgets for Inputs
  Widget _buildFormLabel(BuildContext context, String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 13.mq(context),
        fontWeight: FontWeight.w500,
        color: const Color(0xFFB3B5BA),
      ),
    );
  }

  Widget _buildCustomInput(
    BuildContext context, {
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String hintText,
    Widget? suffixWidget,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF101828).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14.mq(context),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
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

  /// Helper Widget for unit toggle capsule
  Widget _buildUnitSelector(
    BuildContext context, {
    required String selectedLabel,
    required String unselectedLabel,
    required bool isSelected,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => onChanged(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF7F7F) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                selectedLabel,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : Colors.grey.shade500,
                  fontSize: 11.mq(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onChanged(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: !isSelected ? const Color(0xFFFF7F7F) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                unselectedLabel,
                style: GoogleFonts.poppins(
                  color: !isSelected ? Colors.white : Colors.grey.shade500,
                  fontSize: 11.mq(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper Sport Select Button
  Widget _buildSportButton(BuildContext context, String sportName) {
    return Obx(() {
      final isSelected = controller.selectedSport.value == sportName;
      return GestureDetector(
        onTap: () => controller.selectSport(sportName),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFF101828).withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Text(
            sportName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 13.mq(context),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  /// Helper Goal Select Card
  Widget _buildGoalCard(BuildContext context, String goalName) {
    return Obx(() {
      final isSelected = controller.selectedGoals.contains(goalName);
      return GestureDetector(
        onTap: () => controller.toggleGoal(goalName),
        child: Container(
          height: 56,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFF101828).withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                goalName,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13.mq(context),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                    size: 14,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
