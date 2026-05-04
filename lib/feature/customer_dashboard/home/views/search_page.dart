import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: context.theme.brightness == Brightness.dark
                            ? AppColors.darkBackgroundColor
                            : context.theme.cardColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: context.theme.brightness == Brightness.dark
                              ? Colors.white10
                              : AppColors.primaryColor.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[400]),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for hot & new restaurants',
                                hintStyle: GoogleFonts.manrope(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.tune,
                            color: context.theme.brightness == Brightness.dark
                                ? Colors.white
                                : AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryPill(
                      context,
                      'Today',
                      Icons.calendar_today_outlined,
                    ),
                    _buildCategoryPill(
                      context,
                      'Free Entry',
                      Icons.local_offer_outlined,
                    ),
                    _buildCategoryPill(
                      context,
                      'Live Music',
                      Icons.music_note_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle(context, 'Search History'),
              const SizedBox(height: 15),
              _buildTagRow(context, [
                'Sushi',
                'Vegan',
                'BBQ',
                'African',
                'Flavor Street',
              ]),
              const SizedBox(height: 10),
              _buildTagRow(context, ['NomNom Spot']),
              const SizedBox(height: 30),
              _buildSectionTitle(context, 'Suggested'),
              const SizedBox(height: 15),
              _buildTagRow(context, [
                'Sushi',
                'Vegan',
                'BBQ',
                'African',
                'Flavor Street',
              ]),
              const SizedBox(height: 30),
              _buildSectionTitle(context, 'Top Restaurants'),
              const SizedBox(height: 15),
              _buildLargeTagRow(context, [
                'Fork & Soul',
                'Golden Skillet',
                'Flavor Street',
              ]),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryPill(BuildContext context, String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: context.theme.brightness == Brightness.dark
            ? AppColors.darkSurfaceColor
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : AppColors.greyColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: context.theme.brightness == Brightness.dark
                  ? Colors.white
                  : context.theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  Widget _buildTagRow(BuildContext context, List<String> tags) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: context.theme.brightness == Brightness.dark
                    ? AppColors.darkSurfaceColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.greyColor,
                ),
              ),
              child: Text(
                tag,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: context.theme.brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.7)
                      : context.theme.textTheme.bodyMedium?.color?.withOpacity(
                          0.7,
                        ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLargeTagRow(BuildContext context, List<String> tags) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkSurfaceColor
                    : const Color(0xFFFFEDDF),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.greyColor,
                ),
              ),
              child: Text(
                tag,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.primaryColor,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
