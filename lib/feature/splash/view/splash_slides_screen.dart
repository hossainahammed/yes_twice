import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_twice/core/constant/image_path.dart';
import '../controller/splash_slides_controller.dart';

class SplashSlidesScreen extends StatelessWidget {
  SplashSlidesScreen({super.key});

  final SplashSlidesController controller = Get.put(SplashSlidesController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// PageView for Full-Screen Slides
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.changePage,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildSlide(
                width: width,
                height: height,
                imagePath: ImagePath.splashScreen1,
                heading: '“Train smarter, not harder.”',
                bodyText: 'Be an inspiration',
              ),
              _buildSlide(
                width: width,
                height: height,
                imagePath: ImagePath.splashScreen2,
                heading: '“Stay focused. Stay consistent.”',
                bodyText: 'Be an inspiration',
              ),
              _buildSlide(
                width: width,
                height: height,
                imagePath: ImagePath.splashScreen1,
                heading: '“Unlock your full potential.”',
                bodyText: 'Be an inspiration',
              ),
            ],
          ),

          /// Skip Button at top right
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            right: 20,
            child: GestureDetector(
              onTap: controller.skip,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFF7F7F),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          /// Overlay Controls at the Bottom
          Positioned(
            bottom: height * 0.05,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Navigation Dots Indicator
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(controller.totalPages, (index) {
                        final isActive = controller.currentPage.value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 6,
                          width: isActive ? 20 : 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    )),

                SizedBox(height: height * 0.035),

                /// Next Button (Uses Reusable Global ElevatedButton Style)
                ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.45, 48),
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide({
    required double width,
    required double height,
    required String imagePath,
    required String heading,
    required String bodyText,
  }) {
    return Stack(
      children: [
        /// Full-Screen Background Image
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),

        /// Smooth Dark Gradient Overlay for optimal text readability
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.5),
                  Colors.black.withValues(alpha: 0.9),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        /// Text Content (Positioned clearly above the bottom controls)
        Positioned(
          bottom: height * 0.22,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Headline (Lora Font)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ),

              SizedBox(height: height * 0.015),

              /// Subtext (Poppins Font)
              Text(
                bodyText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFB3B5BA), // Sub text color
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
