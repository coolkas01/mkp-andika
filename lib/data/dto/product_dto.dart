import '../../domain/entity/product.dart';
import '../../domain/entity/rating.dart';

class ProductDto extends Product {
  ProductDto({
    required super.id,
    required super.title,
    required super.price,
    super.description,
    super.category,
    super.image,
    super.rating,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      ProductDto(
        id: json['id'],
        title: json['title'],
        price: json['price'] + .0,
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rating(
          rate: json['rating']['rate'] + .0,
          count: json['rating']['count'],
        ),
      );
}