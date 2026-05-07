import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/app_colors.dart';

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage1({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),

          /// ─── Image Card ────────────────────────────────────────────────
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Faint background circle
                Container(
                  width: width * 0.7,
                  height: width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                ),
                // Main Card
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            child: Image.asset(
                              'assets/images/onbording_Background01.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.025,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: width * 0.1,
                                  height: width * 0.1,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.explore_outlined,
                                    color: Colors.white,
                                    size: width * 0.05,
                                  ),
                                ),
                                SizedBox(width: width * 0.035),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: width * 0.18,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.035,
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.secondaryColor,
                              size: width * 0.04,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PARIS, FR',
                              style: GoogleFonts.manrope(
                                fontSize: width * 0.028,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.05),

          /// ─── Title ──────────────────────────────────────────────
          Text(
            'Discover Local\nFlavor',
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSerif(
              fontSize: width * 0.08,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryColor,
              height: 1.2,
            ),
          ),

          SizedBox(height: height * 0.025),

          /// ─── Description ─────────────────────────────────────────
          Text(
            'Explore hidden gems, local favorites,\nand unforgettable tastes around you.\nYour next favorite spot is just around\nthe corner.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
              height: 1.5,
            ),
          ),
          SizedBox(height: height * 0.025),
        ],
      ),
    ),
  ),

  /// ─── Buttons ────────────────────────────────────────────
  ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: Size(double.infinity, height * 0.065),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height * 0.03),
              ),
              elevation: 0,
            ),
            child: Text(
              'Next',
              style: GoogleFonts.manrope(
                fontSize: width * 0.038,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: height * 0.015),

          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip',
              style: GoogleFonts.manrope(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
            ),
          ),

          SizedBox(height: height * 0.025),
        ],
      ),
    );
  }
}
