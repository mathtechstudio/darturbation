part of '../../darturbation.dart';

/// Represents a product with various attributes relevant to an e-commerce or catalog system.
///
/// This model captures detailed information about a product, including its
/// unique identifier, name, categorization, pricing, inventory, and other
/// descriptive and operational attributes.
class Product {
  /// A unique identifier for the product.
  final String id;

  /// The name of the product.
  final String name;

  /// The main category to which the product belongs (e.g., 'electronics', 'fashion').
  final String category;

  /// A more specific subcategory within the main category (e.g., 'smartphone', 'jeans').
  final String subcategory;

  /// A detailed description of the product.
  final String description;

  /// The current selling price of the product.
  final double price;

  /// The original price of the product before any discounts or promotions.
  final double originalPrice;

  /// The brand name of the product.
  final String brand;

  /// The Stock Keeping Unit (SKU) for the product, a unique identifier for inventory.
  final String sku;

  /// The current number of units of the product available in stock.
  final int stock;

  /// The average rating of the product, typically on a scale (e.g., 1.0 to 5.0).
  final double rating;

  /// The total number of reviews the product has received.
  final int reviewCount;

  /// A list of URLs or paths to images of the product.
  final List<String> images;

  /// A map for any additional, unstructured attributes of the product (e.g., color, size).
  final Map<String, dynamic> attributes;

  /// The date and time when the product was added to the system.
  final DateTime createdDate;

  /// A boolean indicating whether the product is currently active and available for sale.
  final bool isActive;

  /// Creates a [Product] instance.
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

  /// Converts this [Product] instance into a JSON-compatible `Map<String, dynamic>`.
  ///
  /// This method is useful for serialization, storage, or API responses.
  /// It converts [DateTime] objects to ISO 8601 strings.
  ///
  /// Returns a `Map<String, dynamic>` representing the product's data.
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
