import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String imagePath;

  CategoryModel({required this.title, required this.imagePath});
}

class RestaurantModel {
  final String name;
  final String location;
  final String priceRange;
  final double rating;
  final String imagePath;

  RestaurantModel({
    required this.name,
    required this.location,
    required this.priceRange,
    required this.rating,
    required this.imagePath,
  });
}

class EventModel {
  final String name;
  final String location;
  final String imagePath;

  EventModel({
    required this.name,
    required this.location,
    required this.imagePath,
  });
}

class ReviewModel {
  final String reviewerName;
  final String reviewerImage;
  final double rating;
  final String reviewText;

  ReviewModel({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.reviewText,
  });
}
