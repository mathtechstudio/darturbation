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

    // Get appropriate brands for this category
    final categoryBrands = IndonesianData.brandsByCategory[category] ??
        IndonesianData.productBrands;
    final brand = Darturbation.randomChoice(categoryBrands);

    // Create more realistic product names
    final productName = _generateProductName(brand, subcategory, category);

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
      brand: brand,
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

  /// Generate realistic product names based on brand, subcategory, and category
  String _generateProductName(
      String brand, String subcategory, String category) {
    switch (category) {
      case 'electronics':
        return _generateElectronicsName(brand, subcategory);
      case 'fashion':
        return _generateFashionName(brand, subcategory);
      case 'food':
        return _generateFoodName(brand, subcategory);
      case 'home':
        return _generateHomeName(brand, subcategory);
      case 'books':
        return _generateBookName(brand, subcategory);
      case 'health':
        return _generateHealthName(brand, subcategory);
      case 'sports':
        return _generateSportsName(brand, subcategory);
      default:
        return '$brand $subcategory';
    }
  }

  String _generateElectronicsName(String brand, String subcategory) {
    final models = ['Pro', 'Max', 'Plus', 'Air', 'Ultra', 'Mini', 'Lite'];
    final numbers = ['12', '13', '14', '15', 'X', 'S', 'SE'];

    switch (subcategory) {
      case 'smartphone':
        return '$brand ${Darturbation.randomChoice([
              'Galaxy',
              'iPhone',
              'Redmi',
              'Note',
              'Find'
            ])} ${Darturbation.randomChoice(numbers)}';
      case 'laptop':
        return '$brand ${Darturbation.randomChoice([
              'ThinkPad',
              'MacBook',
              'VivoBook',
              'IdeaPad',
              'Pavilion'
            ])} ${Darturbation.randomChoice(models)}';
      case 'tv':
        return '$brand Smart TV ${Darturbation.randomInt(32, 75)}" 4K';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(models)}';
    }
  }

  String _generateFashionName(String brand, String subcategory) {
    final colors = ['Hitam', 'Putih', 'Biru', 'Merah', 'Abu-abu', 'Navy'];

    switch (subcategory) {
      case 'kaos':
        return '$brand Kaos ${Darturbation.randomChoice(colors)} ${Darturbation.randomChoice([
              'Premium',
              'Basic',
              'Slim Fit'
            ])}';
      case 'kemeja':
        return '$brand Kemeja ${Darturbation.randomChoice(colors)} ${Darturbation.randomChoice([
              'Formal',
              'Casual',
              'Slim Fit'
            ])}';
      case 'celana':
        return '$brand Celana ${Darturbation.randomChoice([
              'Jeans',
              'Chino',
              'Jogger'
            ])} ${Darturbation.randomChoice(colors)}';
      case 'sepatu':
        return '$brand Sepatu ${Darturbation.randomChoice([
              'Sneakers',
              'Formal',
              'Casual',
              'Running'
            ])}';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(colors)}';
    }
  }

  String _generateFoodName(String brand, String subcategory) {
    final flavors = [
      'Original',
      'Pedas',
      'Ayam Bawang',
      'Soto',
      'Rendang',
      'Ayam Geprek'
    ];
    final variants = ['100gr', '200gr', '500ml', '1L', '250ml'];

    switch (subcategory) {
      case 'makanan instan':
        return '$brand Mie Instan ${Darturbation.randomChoice(flavors)}';
      case 'minuman':
        return '$brand ${Darturbation.randomChoice([
              'Teh',
              'Air Mineral',
              'Jus',
              'Susu'
            ])} ${Darturbation.randomChoice(variants)}';
      case 'bumbu masak':
        return '$brand ${Darturbation.randomChoice([
              'Kecap',
              'Sambal',
              'Bumbu',
              'Penyedap'
            ])} ${Darturbation.randomChoice(['Manis', 'Asin', 'Pedas'])}';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(variants)}';
    }
  }

  String _generateHomeName(String brand, String subcategory) {
    final types = ['Premium', 'Deluxe', 'Basic', 'Pro', 'Smart'];

    switch (subcategory) {
      case 'peralatan dapur':
        return '$brand ${Darturbation.randomChoice([
              'Rice Cooker',
              'Blender',
              'Mixer',
              'Kompor'
            ])} ${Darturbation.randomChoice(types)}';
      case 'furniture':
        return '$brand ${Darturbation.randomChoice([
              'Sofa',
              'Meja',
              'Kursi',
              'Lemari'
            ])} ${Darturbation.randomChoice(types)}';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(types)}';
    }
  }

  String _generateBookName(String brand, String subcategory) {
    final titles = [
      'Belajar Pemrograman',
      'Sejarah Indonesia',
      'Matematika Dasar',
      'Bahasa Inggris',
      'Novel Remaja',
      'Motivasi Hidup'
    ];

    return '$brand ${Darturbation.randomChoice(titles)}';
  }

  String _generateHealthName(String brand, String subcategory) {
    final variants = ['50ml', '100ml', '200ml', '30 tablet', '60 kapsul'];

    switch (subcategory) {
      case 'skincare':
        return '$brand ${Darturbation.randomChoice([
              'Face Wash',
              'Moisturizer',
              'Serum',
              'Toner'
            ])} ${Darturbation.randomChoice(variants)}';
      case 'makeup':
        return '$brand ${Darturbation.randomChoice([
              'Lipstik',
              'Foundation',
              'Bedak',
              'Mascara'
            ])}';
      case 'vitamin':
        return '$brand Vitamin ${Darturbation.randomChoice([
              'C',
              'D',
              'E',
              'B Complex'
            ])} ${Darturbation.randomChoice(variants)}';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(variants)}';
    }
  }

  String _generateSportsName(String brand, String subcategory) {
    final types = ['Pro', 'Elite', 'Training', 'Performance'];

    switch (subcategory) {
      case 'sepatu olahraga':
        return '$brand Sepatu ${Darturbation.randomChoice([
              'Running',
              'Basketball',
              'Football',
              'Training'
            ])} ${Darturbation.randomChoice(types)}';
      case 'baju olahraga':
        return '$brand Jersey ${Darturbation.randomChoice([
              'Football',
              'Basketball',
              'Running'
            ])} ${Darturbation.randomChoice(types)}';
      default:
        return '$brand $subcategory ${Darturbation.randomChoice(types)}';
    }
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
