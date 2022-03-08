import 'package:toy_app/model/custom_image.dart';

class Product {
  final int id;
  final String name;
  final String shortdescription;
  final String fulldescription;
  final double price;
  final int approvedratingsum;
  final List<CustomImage> images;
  Product({
    required this.id,
    required this.name,
    required this.shortdescription,
    required this.fulldescription,
    required this.price,
    required this.approvedratingsum,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<CustomImage> imageParse = <CustomImage>[];
    if (json['images'] != null) {
      imageParse =
          (json['images'] as List).map((i) => CustomImage.fromJson(i)).toList();
    }
    return Product(
      id: json['id'],
      name: json['name'],
      shortdescription: json['short_description'],
      fulldescription: json['full_description'],
      price: json['price'],
      // images: [],
      images: imageParse,
      approvedratingsum: json['approved_rating_sum'],
    );
  }
}
