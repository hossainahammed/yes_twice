import 'package:get/get.dart';
import '../models/home_models.dart';

class HomeController extends GetxController {
  final categories = <CategoryModel>[
    CategoryModel(title: 'Pizza', imagePath: 'assets/images/pizza.png'),
    CategoryModel(title: 'Burger', imagePath: 'assets/images/burger.png'),
    CategoryModel(title: 'Sushi', imagePath: 'assets/images/sushi.png'),
    CategoryModel(title: 'Drinks', imagePath: 'assets/images/drinks.png'),
  ].obs;

  final restaurants = <RestaurantModel>[
    RestaurantModel(
      name: 'The Southern Spoon',
      location: 'Johannesburg',
      priceRange: '\$\$',
      rating: 4.9,
      imagePath: 'assets/images/nearbyresturants.png',
    ),
    RestaurantModel(
      name: 'Spice Theory',
      location: 'Johannesburg',
      priceRange: '\$\$\$',
      rating: 4.8,
      imagePath: 'assets/images/nearbyresturants.png',
    ),
  ].obs;

  final eventsNearby = <EventModel>[
    EventModel(
      name: 'Event Name',
      location: '4093 Overlook Drive',
      imagePath: 'assets/images/nearbyEvents1.png',
    ),
    EventModel(
      name: 'Event Name',
      location: '4093 Overlook Drive',
      imagePath: 'assets/images/nearbyEvents2.png',
    ),
    EventModel(
      name: 'Event Name',
      location: '4093 Overlook Drive',
      imagePath: 'assets/images/nearbyEvents1.png',
    ),
    EventModel(
      name: 'Event Name',
      location: '4093 Overlook Drive',
      imagePath: 'assets/images/nearbyEvents2.png',
    ),
  ].obs;

  final reviews = <ReviewModel>[
    ReviewModel(
      reviewerName: 'Kurt Bates',
      reviewerImage: 'assets/images/recentViewCard.png',
      rating: 4.0,
      reviewText:
          'Donec Dictum Tristique Porta. Etiam Convallis Lorem Lobortis Nulla Molestie, Nec Tincidunt Ex Ullamcorper. Quisque Ultrices Lobortis Elit Sed Euismod.',
    ),
    ReviewModel(
      reviewerName: 'Kurt Bates',
      reviewerImage: 'assets/images/recentViewCard.png',
      rating: 4.0,
      reviewText:
          'Donec Dictum Tristique Porta. Etiam Convallis Lorem Lobortis Nulla Molestie, Nec Tincidunt Ex Ullamcorper. Quisque Ultrices Lobortis Elit Sed Euismod.',
    ),
    ReviewModel(
      reviewerName: 'Kurt Bates',
      reviewerImage: 'assets/images/recentViewCard.png',
      rating: 4.0,
      reviewText:
          'Donec Dictum Tristique Porta. Etiam Convallis Lorem Lobortis Nulla Molestie, Nec Tincidunt Ex Ullamcorper. Quisque Ultrices Lobortis Elit Sed Euismod.',
    ),
  ].obs;
}
