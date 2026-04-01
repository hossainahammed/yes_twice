import 'package:get/get.dart';

class ExploreItem {
  final String imagePath;
  final String title;
  final double rating;
  final String category;
  final String distance;
  final String subCategory;

  ExploreItem({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.category,
    required this.distance,
    required this.subCategory,
  });
}

class ExploreController extends GetxController {
  final List<ExploreItem> exploreItems = [
    ExploreItem(
      imagePath: 'assets/images/food01.png',
      title: 'Smokehouse',
      rating: 4.9,
      category: 'Asian',
      distance: '2.5 mile',
      subCategory: 'Italian',
    ),
    ExploreItem(
      imagePath: 'assets/images/popularFoodSpots.png',
      title: 'Smokehouse',
      rating: 4.8,
      category: 'Asian',
      distance: '1.2 mile',
      subCategory: 'Mexican',
    ),
    ExploreItem(
      imagePath: 'assets/images/burger.png',
      title: 'Smokehouse',
      rating: 4.9,
      category: 'American',
      distance: '3.0 mile',
      subCategory: 'Fast Food',
    ),
  ];
}
