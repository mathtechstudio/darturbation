part of '../../darturbation.dart';

class ProductGenerator {
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

  Stream<Product> streamGenerate({int count = 10}) async* {
    for (int i = 0; i < count; i++) {
      yield generate();
    }
  }
}
