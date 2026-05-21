import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Filter',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 24),
            Text('SORT BY', style: _sectionTitleStyle(context)),
            _buildSortOption('Nearest to Me', false, context),
            _buildSortOption('Recommended', true, context),
            _buildSortOption('Rating (High to Low)', false, context),
            // _buildSortOption('Price (Low to High)', false),
            const SizedBox(height: 24),
            Text('CUISINE TYPE', style: _sectionTitleStyle(context)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTag('Italian', true, context),
                _buildTag('French', false, context),
                _buildTag('Japanese', false, context),
                _buildTag('Thai', false, context),
                _buildTag('Mediterranean', false, context),
                _buildTag('Mexican', false, context),
                //_buildTag('Steakhouse', false),
              ],
            ),
            //  const SizedBox(height: 24),
            // Text('PRICE RANGE', style: _sectionTitleStyle()),
            // const SizedBox(height: 12),
            // Row(
            //   children: [
            //     Expanded(child: _buildPriceField('min')),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16),
            //       child: Text(
            //         'TO',
            //         style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     Expanded(child: _buildPriceField('max')),
            //   ],
            // ),
            const SizedBox(height: 24),
            Text('MINIMUM RATING', style: _sectionTitleStyle(context)),
            const SizedBox(height: 12),
            Row(
              children: [
                ...List.generate(
                  4,
                  (index) => Icon(
                    Icons.star,
                    color: context.theme.brightness == Brightness.dark
                        ? Colors.deepOrange
                        : AppColors.primaryColor,
                    // color: AppColors.primaryColor,
                    size: 24,
                  ),
                ),
                Icon(
                  Icons.star_border,
                  color: context.theme.brightness == Brightness.dark
                      ? Colors.deepOrange
                      : AppColors.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '4.0 & Up',
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Open Now',
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    Text(
                      'Only show currently open restaurants',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      'Clear All',
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryColor
                          : AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.manrope(
                        //color: Theme.brightnessOf(context) == Brightness.dark
                         color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[400]
          : Colors.grey[700],
      letterSpacing: 1,
    );
  }

  Widget _buildSortOption(String label, bool isSelected, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected
                ? (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryColor
                      : AppColors.primaryColor)
                : Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, bool isSelected, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryColor
            : (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF2EB)),
        borderRadius: BorderRadius.circular(20),
        border: !isSelected && isDark
            ? Border.all(color: Colors.white10)
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected
              ? Colors.white
              : (isDark ? Colors.white70 : AppColors.primaryColor),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriceField(String hint, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF2EB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          hint,
          style: GoogleFonts.manrope(
            color: isDark ? Colors.white70 : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
