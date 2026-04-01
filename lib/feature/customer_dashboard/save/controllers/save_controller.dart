import 'package:get/get.dart';

class SavedItem {
  final String imagePath;
  final String title;
  final String location;
  final double rating;
  final String priceOrCategory;
  final int reviews;

  SavedItem({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.rating,
    required this.priceOrCategory,
    this.reviews = 1223,
  });
}

class SaveController extends GetxController {
  var selectedTabIndex = 1.obs; // Default to Food tab as per the user instruction

  final List<String> tabs = ['Restaurant', 'Food', 'Event'];

  final List<SavedItem> savedRestaurants = [
    SavedItem(
      imagePath: 'assets/images/restaurent.png',
      title: 'Spice Theory',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: r'$$$',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyresturants.png',
      title: 'Ezhe Source',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: r'$$$',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyresturants1.png',
      title: 'Super Duper',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: r'$$$',
    ),
    SavedItem(
      imagePath: 'assets/images/popularFoodSpots.png',
      title: 'Ezhe Source',
      location: 'Johannesburg',
      rating: 4.5,
      priceOrCategory: r'$$',
    ),
    SavedItem(
      imagePath: 'assets/images/popularFoodSpots1.png',
      title: 'Ezhe Source',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: r'$$',
    ),
    SavedItem(
      imagePath: 'assets/images/food01.png',
      title: 'Ezhe Source',
      location: 'Johannesburg',
      rating: 4.5,
      priceOrCategory: r'$$$',
    ),
  ];

  final List<SavedItem> savedFoods = [
    SavedItem(
      imagePath: 'assets/images/restaurent.png',
      title: 'Spice Theory',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyresturants.png',
      title: 'Ezhe Source',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyresturants1.png',
      title: 'Super Duper',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
    SavedItem(
      imagePath: 'assets/images/popularFoodSpots.png',
      title: 'Ezhe Source',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
    SavedItem(
      imagePath: 'assets/images/popularFoodSpots1.png',
      title: 'Ezhe Source',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
    SavedItem(
      imagePath: 'assets/images/food01.png',
      title: 'Ezhe Source',
      location: '',
      rating: 4.9,
      priceOrCategory: r'Asian · $$',
    ),
  ];

  final List<SavedItem> savedEvents = [
    SavedItem(
      imagePath: 'assets/images/event01.png',
      title: 'Fried Rice With Vegetable',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: '',
    ),
    SavedItem(
      imagePath: 'assets/images/event02.jpg',
      title: 'Event Name',
      location: '4093 Overlook Drive',
      rating: 4.9,
      priceOrCategory: '',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyEvents1.png',
      title: 'Event Name',
      location: '4093 Overlook Drive',
      rating: 4.9,
      priceOrCategory: '',
    ),
    SavedItem(
      imagePath: 'assets/images/nearbyEvents2.png',
      title: 'Fried Rice With Vegetable',
      location: 'Johannesburg',
      rating: 4.9,
      priceOrCategory: '',
    ),
  ];

  void switchTab(int index) {
    selectedTabIndex.value = index;
  }
}
