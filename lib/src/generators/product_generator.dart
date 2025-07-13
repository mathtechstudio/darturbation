part of '../../darturbation.dart';

/// Generates realistic [Product] data.
///
/// The [ProductGenerator] creates individual product instances and streams of
/// products, ensuring that they have market-realistic attributes, prices,
/// and categories.
class ProductGenerator {
  /// Generates a single [Product] object.
  ///
  /// This method creates a product with a randomly chosen category and subcategory,
  /// a realistic name, and a price influenced by a randomly selected price preference.
  /// It also includes other attributes like SKU, stock, rating, and images.
  ///
  /// Returns a [Product] instance with generated details.
  Product generate() {
    final categories = IndonesianData.productCategories.keys.toList();
    final category = Darturbation.randomChoice(categories);
    final subcategories = IndonesianData.productCategories[category]!;
    final subcategory = Darturbation.randomChoice(subcategories);
    final productName =
        '${Darturbation.randomChoice(IndonesianData.productBrands)} $subcategory';
    final pricePreference =
        Darturbation.randomChoice(BehavioralPatterns.priceRanges.keys.toList());
    final price = DarturbationCore()
        .patterns
        .getRealisticPrice(category, pricePreference);
    final originalPrice = price * Darturbation.randomDouble(1, 1.5);

    return Product(
      id: Darturbation.generateId(),
      name: productName,
      category: category,
      subcategory: subcategory,
      description: Darturbation._faker.lorem.sentence(),
      price: price,
      originalPrice: originalPrice,
      brand: Darturbation.randomChoice(IndonesianData.productBrands),
      sku: IndonesianData.generateSKU(category),
      stock: Darturbation.randomInt(0, 1000),
      rating: Darturbation.randomDouble(1, 5),
      reviewCount: Darturbation.randomInt(0, 500),
      images: ['https://via.placeholder.com/150'],
      attributes: {},
      createdDate: DateTime.now()
          .subtract(Duration(days: Darturbation.randomInt(0, 730))),
      isActive: Darturbation.randomBool(),
    );
  }

  /// Generates a [Stream] of [Product] objects.
  ///
  /// This method is suitable for generating a large number of products efficiently
  /// without holding all of them in memory simultaneously. Each product is generated
  /// and yielded as it becomes available.
  ///
  /// Parameters:
  /// - [count]: The total number of products to generate in the stream (default: 10).
  ///
  /// Returns a [Stream<Product>] that yields generated products.
  Stream<Product> streamGenerate({int count = 10}) async* {
    for (int i = 0; i < count; i++) {
      yield generate();
    }
  }
}
