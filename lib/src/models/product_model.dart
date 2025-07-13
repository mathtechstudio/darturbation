part of '../../darturbation.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final String description;
  final double price;
  final double originalPrice;
  final String brand;
  final String sku;
  final int stock;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final Map<String, dynamic> attributes;
  final DateTime createdDate;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.brand,
    required this.sku,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.attributes,
    required this.createdDate,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'brand': brand,
      'sku': sku,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'images': images,
      'attributes': attributes,
      'createdDate': createdDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
