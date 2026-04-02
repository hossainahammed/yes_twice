import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';
import 'gallery_page.dart';
import 'review_page.dart';
import 'all_reviews_page.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomBackButton(),
        ),
        title: Text(
          'Details',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              24,
              100,
            ), // padding bottom for fixed button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageGallery(),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.topCenter,
                  child: _buildSeeMoreButton(),
                ),
                const SizedBox(height: 16),
                _buildHeaderRow(context),
                const SizedBox(height: 8),
                _buildInfoRows(),
                const SizedBox(height: 20),
                Container(height: 1, color: Colors.grey.shade100),
                const SizedBox(height: 16),
                _buildDescriptionSection(),
                const SizedBox(height: 16),
                _buildContactInfo(),
                const SizedBox(height: 20),
                Container(height: 1, color: Colors.grey.shade100),
                const SizedBox(height: 16),
                _buildSectionHeader('Dishes', () {}),
                const SizedBox(height: 12),
                _buildDishesList(),
                const SizedBox(height: 20),
                Container(height: 1, color: Colors.grey.shade100),
                const SizedBox(height: 16),
                _buildSectionHeader('Recent Reviews', () => Get.to(() => const AllReviewsPage())),
                const SizedBox(height: 12),
                _buildRecentReviews(),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // Fixed bottom button
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const ReviewPage()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size(double.infinity, 52),
              ),
              child: Text(
                'Add review',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/restaurent.png', // Main image
                    fit: BoxFit.cover,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/nearbyresturants.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/popularFoodSpots.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/food01.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[200]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 12,
        //   right: 30, // Offset a bit inside the right column
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        //     decoration: BoxDecoration(
        //       color: AppColors.primaryColor,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Text(
        //       'See all Image',
        //       style: GoogleFonts.manrope(
        //         color: Colors.white,
        //         fontSize: 10,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSeeMoreButton() {
    return GestureDetector(
      onTap: () => Get.to(() => const GalleryPage()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.grid_view_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              'See More',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Smokehouse',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.favorite_rounded,
              color: AppColors.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _showShareBottomSheet(context),
              child: Transform.flip(
                flipX: true,
                child: const Icon(
                  Icons.reply_rounded,
                  color: Colors.black54,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              'Asian · 2.5 mile',
              style: GoogleFonts.manrope(
                fontSize: 11,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.access_time_filled,
              color: AppColors.primaryColor,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              '08:00 - 22:00  ',
              style: GoogleFonts.manrope(
                fontSize: 11,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'OPEN',
              style: GoogleFonts.manrope(
                fontSize: 10,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Description',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 12),
                const SizedBox(width: 4),
                Text(
                  '4.9',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Smokehouse brings the bold flavors of Southern-style barbecue to your plate with slow-cooked, fall-off-the-bone meats, house-made sauces, and hearty sides. Known for its signature smoked ribs and pulled pork sandwiches, this casual spot combines rustic charm with mouthwatering comfort food.',
          style: GoogleFonts.manrope(
            fontSize: 10,
            color: Colors.grey[500],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.primaryColor, size: 14),
            const SizedBox(width: 8),
            Text(
              '123-456-7890',
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
              size: 14,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '123 Foodie Lane, Johannesburg, SA',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                'See all',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.primaryColor,
                size: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDishesList() {
    final dishes = [
      {'name': 'Pizza', 'image': 'assets/images/pizza.png', 'rating': '4.9'},
      {
        'name': 'Chinese',
        'image': 'assets/images/restaurent.png',
        'rating': '4.9',
      },
      {'name': 'Burgers', 'image': 'assets/images/burger.png', 'rating': '4.9'},
    ];

    return Column(
      children: dishes.map((dish) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  dish['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(width: 50, height: 50, color: Colors.grey[200]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish['name']!,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 10),
                        const SizedBox(width: 4),
                        Text(
                          dish['rating']!,
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '(1223)',
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const ReviewPage()),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Text(
                    'Leave a Review',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentReviews() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/Composer.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(width: 40, height: 40, color: Colors.grey[200]),
                ),
              ),
              const SizedBox(width: 12),
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
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 10,
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod.',
                      style: GoogleFonts.manrope(
                        fontSize: 9,
                        color: Colors.grey[500],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Share',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    title: 'Copy Link',
                    icon: Icons.copy,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  _buildShareOption(
                    title: 'WhatsApp',
                    icon: Icons.chat,
                    backgroundColor: Colors.green,
                  ),
                  _buildShareOption(
                    title: 'Instagram',
                    icon: Icons.camera_alt,
                    isGradient: true,
                  ),
                  _buildShareOption(
                    title: 'TikTok',
                    icon: Icons.music_note,
                    backgroundColor: Colors.pinkAccent,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption({
    required String title,
    required IconData icon,
    Color? backgroundColor,
    bool isGradient = false,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isGradient ? null : backgroundColor,
            gradient: isGradient
                ? const LinearGradient(
                    colors: [
                      Color(0xFF833AB4),
                      Color(0xFFFD1D1D),
                      Color(0xFFF56040),
                      Color(0xFFFFDC80),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
