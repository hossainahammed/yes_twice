import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/app_colors.dart';
import '../../../feature/dashboard/controller/dashboard_controller.dart';
import '../../../feature/dashboard/view/dashboard_screen.dart';

/// Reusable shared bottom navigation bar widget
class BottomNavBar extends StatelessWidget {
  final int activeIndex;
  const BottomNavBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'label': 'Home', 'icon': 'assets/icons/home.png'},
      {'label': 'Training', 'icon': 'assets/icons/training.png'},
      {'label': 'Calendar', 'icon': 'assets/icons/calender.png'},
      {'label': 'Recovery', 'icon': 'assets/icons/recovery.png'},
      {'label': 'Profile', 'icon': 'assets/icons/profile.png'},
    ];

    // Fallback icons for each tab
    const fallbackIcons = [
      Icons.home_outlined,
      Icons.flash_on_outlined,
      Icons.calendar_today_outlined,
      Icons.favorite_border_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: 80, // Increased height to prevent bottom safe-area overflow
      decoration: BoxDecoration(
        color: AppColors.shade2, // 0xFF080808 — deep near-black
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabs.length, (index) {
            final isActive = index == activeIndex;
            final item = tabs[index];

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final dashboardController = Get.put(DashboardController());
                dashboardController.changeTab(index);
                if (Navigator.of(context).canPop()) {
                  Get.offAll(() => const DashboardScreen());
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ), // Muted vertical padding to prevent overflow
                decoration: BoxDecoration(
                  // Active tab: subtle pink-tinted pill background
                  color:
                      isActive
                          ? AppColors.shade3.withValues(alpha: 0.13)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  // Active tab: soft pink glow border
                  border:
                      isActive
                          ? Border.all(
                            color: AppColors.shade3.withValues(alpha: 0.25),
                            width: 1.0,
                          )
                          : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon — colored white when active, subTextColor when not
                    Image.asset(
                      item['icon']!,
                      width:
                          20, // Reverted to 20 for extra safety on small devices
                      height: 20,
                      color:
                          isActive
                              ? AppColors
                                  .shade3 // Pink accent for active
                              : AppColors
                                  .subTextColor, // Muted grey for inactive
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          fallbackIcons[index],
                          color:
                              isActive
                                  ? AppColors.shade3
                                  : AppColors.subTextColor,
                          size: 20,
                        );
                      },
                    ),
                    const SizedBox(height: 3),
                    // Label
                    Text(
                      item['label']!,
                      style: GoogleFonts.poppins(
                        fontSize: 9.5.mq(context), // Slightly smaller text to prevent any overflow on standard screens
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w400,
                        color:
                            isActive
                                ? AppColors
                                    .shade3 // Pink accent label
                                : AppColors.subTextColor, // Muted label
                        letterSpacing: isActive ? 0.2 : 0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
