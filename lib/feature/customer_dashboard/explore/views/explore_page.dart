import 'package:bolaji277/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../controllers/explore_controller.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  
  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.exploreItems.length,
        itemBuilder: (context, index) {
          final item = controller.exploreItems[index];
          return _buildExploreItem(context, item);
        },
      ),
    );
  }

  Widget _buildExploreItem(BuildContext context, ExploreItem item) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          item.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Container(color: Colors.grey[800]),
        ),
        
        // Gradient overlay for better text readability at bottom and top
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.2, 0.6, 1.0],
            ),
          ),
        ),

        // Safar Area for top content
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Title
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Explore',
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              // Middle Play Button
              const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 80,
              ),

              // Bottom Content Area
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, screenHeight * 0.04), // Adjust padding for nav bar
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Left Details (Title & Chip Row)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Chips Row
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildGlassChip(
                                  icon: Icons.star,
                                  iconColor: Colors.orange,
                                  text: item.rating.toString(),
                                  textColor: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                _buildGlassChip(
                                  icon: Icons.location_on,
                                  iconColor: AppColors.primaryColor,
                                  text: item.category,
                                  textColor: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                _buildGlassChip(
                                  icon: Icons.location_on,
                                  iconColor: AppColors.primaryColor,
                                  text: item.distance,
                                  textColor: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                _buildGlassChip(
                                  text: item.subCategory,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Right actions (Likes, Share)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildActionIcon(
                          icon: Icons.favorite,
                          label: 'Likes',
                          onTap: () {
                            if (AuthService.to.checkAuthAndPrompt()) {
                              // Logic to like
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildActionIcon(
                          icon: Icons.reply, // Closest material icon for Share looking like the image
                          label: 'Share',
                          isMirrored: true, // Flip to point right
                          onTap: () => _showShareBottomSheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassChip({
    IconData? icon,
    Color? iconColor,
    required String text,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism translucent
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 12),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: GoogleFonts.manrope(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isMirrored = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Transform.flip(
            flipX: isMirrored,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // To show rounded corners cleanly
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle pill
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Share',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // Divider
              Divider(color: Theme.of(context).dividerColor, thickness: 1),
              const SizedBox(height: 20),
              // Share options row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareOption(
                    context,
                    title: 'Copy Link',
                    icon: Icons.copy,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  _buildShareOption(
                    context,
                    title: 'WhatsApp',
                    icon: Icons.chat,
                    backgroundColor: Colors.green,
                  ),
                  _buildShareOption(
                    context,
                    title: 'Instagram',
                    icon: Icons.camera_alt,
                    isGradient: true,
                  ),
                  _buildShareOption(
                    context,
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

  Widget _buildShareOption(
    BuildContext context, {
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
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
