import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                0,
                "assets/icons/home_selected.png",
                "assets/icons/home_selected.png",
                'Home',
              ),
              _buildNavItem(
                context,
                1,
                "assets/icons/explore.png",
                "assets/icons/explore_selected.png",
                'Explore',
              ),
              _buildNavItem(
                context,
                2,
                "assets/icons/save.png",
                "assets/icons/save_selected.png",
                'Save',
              ),
              _buildNavItem(
                context,
                3,
                "assets/icons/more.png",
                "assets/icons/more_selected.png",
                'More',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    String outlinedIcon,
    String filledIcon,
    String label,
  ) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 2),
            Image.asset(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              width: 26,
              height: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
