import 'package:mitra/domain/entity/rating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  @override
  String toString() =>
      '$id, $title, $price, $description, $category, $image, $rating';
}