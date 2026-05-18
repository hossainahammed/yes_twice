import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/widgets/custom_auth_widgets.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<String> images = [
    'assets/images/resturant_details01.png',
    'assets/images/resturant_details02.png',
    'assets/images/resturant_details03.png',
    'assets/images/pizza.png',
    'assets/images/burger.png',
    'assets/images/food01.png',
    'assets/images/nearbyresturants.png',
    'assets/images/popularFoodSpots.png',
    'assets/images/restaurent.png',
    'assets/images/resturant_details01.png',
    'assets/images/resturant_details02.png',
    'assets/images/resturant_details03.png',
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomBackButton(
            onTap: () {
              if (selectedIndex != null) {
                setState(() => selectedIndex = null);
              } else {
                Get.back();
              }
            },
          ),
        ),
        title: Text(
          'Gallery',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: selectedIndex != null ? _buildImageView() : _buildGalleryGrid(),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => setState(() => selectedIndex = index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: context.theme.cardColor),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageView() {
    return Center(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView.builder(
            controller: PageController(initialPage: selectedIndex!),
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 34,
            right: 34,
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = null),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
