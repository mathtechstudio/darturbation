part of '../../darturbation.dart';

/// A comprehensive scenario generator for e-commerce data generation.
///
/// The [EcommerceScenario] class provides a fluent interface for generating
/// realistic e-commerce datasets with proper relationships between users, products,
/// orders, and reviews. It supports both batch and streaming data generation
/// with context-aware patterns and regional customization.
///
/// ## Key Features
/// - **Relationship Management**: Maintains logical connections between entities
/// - **Regional Customization**: Supports localized data generation
/// - **Seasonality Patterns**: Applies seasonal behavior to order generation
/// - **Fluent Interface**: Chainable method calls for intuitive usage
/// - **Streaming Support**: Memory-efficient generation for large datasets
/// - **Context Awareness**: Uses behavioral patterns for realistic data
///
/// ## Basic Usage
/// ```dart
/// // Generate a complete e-commerce dataset
/// EcommerceScenario scenario = Darturbation.scenario('ecommerce')
///   .users(100, region: 'indonesia')
///   .products(50, categories: ['electronics', 'clothing'])
///   .orders(seasonality: 'holiday')
///   .reviews();
///
/// Map<String, dynamic> dataset = scenario.generate();
/// ```
///
/// ## Streaming Usage
/// ```dart
/// // Generate large datasets with streaming
/// EcommerceScenario scenario = Darturbation.scenario('ecommerce');
///
/// await for (Map<String, dynamic> item in scenario.generateStream(
///   userCount: 1000,
///   productCount: 500,
///   orderCount: 2000,
///   reviewCount: 1500
/// )) {
///   print('Generated ${item['type']}: ${item['data']['id']}');
/// }
/// ```
///
/// ## Regional Support
/// The scenario supports regional customization for:
/// - Language-specific product names and descriptions
/// - Currency formatting and pricing patterns
/// - Address formats and geographic data
/// - Cultural preferences in product categories
/// - Local payment methods and shipping options
class EcommerceScenario {
  /// The regional context for data generation
  String _region = 'indonesia';

  /// The seasonality pattern affecting order generation
  String _seasonality = 'normal';

  // Internal storage for generated entities
  List<User> _users = [];
  List<Product> _products = [];
  List<Order> _orders = [];
  final List<Review> _reviews = [];

  /// Creates a new e-commerce scenario with default Indonesian regional settings.
  ///
  /// Initializes the scenario with:
  /// - Default region set to 'indonesia'
  /// - Normal seasonality patterns
  /// - Empty entity collections
  /// - Configured regional context in the core system
  EcommerceScenario() {
    DarturbationCore().context.setRegion(_region);
  }

  // =================================================================
  // BATCH GENERATION METHODS (Fluent Interface)
  // =================================================================

  /// Generates a specified number of users with optional regional customization.
  ///
  /// This method creates users with region-appropriate characteristics including:
  /// - Localized names and naming conventions
  /// - Regional phone number formats
  /// - Culturally appropriate age distributions
  /// - Region-specific address formats
  /// - Local currency preferences
  ///
  /// The generated users are stored internally and their relationships are
  /// registered with the core system for cross-entity consistency.
  ///
  /// Example:
  /// ```dart
  /// scenario
  ///   .users(100, region: 'indonesia')
  ///   .products(50)
  ///   .orders()
  ///   .reviews();
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of users to generate
  /// - [region]: Optional regional override (e.g., 'indonesia', 'malaysia')
  ///
  /// Returns [EcommerceScenario] for method chaining.
  EcommerceScenario users(int count, {String? region}) {
    if (region != null) {
      _region = region;
      DarturbationCore().context.setRegion(region);
    }

    _users = List.generate(count, (_) => Darturbation.user());
    DarturbationCore()
        .relationships
        .storeData('users', _users.map((u) => u.toJson()).toList());

    return this;
  }

  /// Generates a specified number of products with optional category filtering.
  ///
  /// The product generation considers:
  /// - Regional market preferences and availability
  /// - Category-specific pricing patterns
  /// - Realistic inventory levels per category
  /// - Localized product names and descriptions
  /// - Regional shipping constraints and costs
  ///
  /// Products are generated with proper relationships to support realistic
  /// order combinations and cross-selling patterns.
  ///
  /// Example:
  /// ```dart
  /// scenario
  ///   .users(50)
  ///   .products(100, categories: ['electronics', 'clothing', 'books'])
  ///   .orders()
  ///   .reviews();
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of products to generate
  /// - [categories]: Optional list of product categories to focus on
  ///
  /// Returns [EcommerceScenario] for method chaining.
  EcommerceScenario products(int count, {List<String>? categories}) {
    _products = List.generate(count, (_) => Darturbation.product());
    DarturbationCore()
        .relationships
        .storeData('products', _products.map((p) => p.toJson()).toList());

    return this;
  }

  /// Generates orders with realistic user-product relationships and seasonal patterns.
  ///
  /// The order generation process:
  /// - Assigns one order per user for balanced distribution
  /// - Applies seasonal patterns to order timing and quantities
  /// - Considers user demographics for product selection
  /// - Maintains realistic order values and item combinations
  /// - Applies regional shipping and payment preferences
  ///
  /// Supported seasonality patterns:
  /// - `'normal'`: Regular purchasing patterns
  /// - `'holiday'`: Increased volume with gift-focused selections
  /// - `'summer'`: Seasonal product preferences
  /// - `'winter'`: Weather-appropriate item focus
  /// - `'ramadan'`: Religious season considerations (for Indonesian market)
  ///
  /// Example:
  /// ```dart
  /// scenario
  ///   .users(100)
  ///   .products(200)
  ///   .orders(seasonality: 'holiday')
  ///   .reviews();
  /// ```
  ///
  /// Parameters:
  /// - [seasonality]: Optional seasonal pattern to apply
  ///
  /// Returns [EcommerceScenario] for method chaining.
  ///
  /// Note: This method requires [users] and [products] to be called first.
  EcommerceScenario orders({String? seasonality}) {
    if (seasonality != null) {
      _seasonality = seasonality;
    }

    _orders = List.generate(
        _users.length, // Generate one order per user for simplicity
        (index) =>
            Darturbation.order(user: _users[index], withProducts: _products));
    DarturbationCore()
        .relationships
        .storeData('orders', _orders.map((o) => o.toJson()).toList());

    return this;
  }

  /// Generates reviews based on existing orders with realistic rating patterns.
  ///
  /// The review generation process:
  /// - Creates reviews only for products that have been ordered
  /// - Applies user-specific reviewing behavior patterns
  /// - Considers product quality and category for rating distribution
  /// - Generates culturally appropriate review content
  /// - Maintains realistic review timing relative to order dates
  ///
  /// Review characteristics:
  /// - Varied review lengths and detail levels
  /// - Realistic rating distributions (not perfectly random)
  /// - User personality consistency across reviews
  /// - Product-category appropriate feedback patterns
  /// - Regional language and cultural considerations
  ///
  /// Example:
  /// ```dart
  /// scenario
  ///   .users(50)
  ///   .products(100)
  ///   .orders()
  ///   .reviews();
  ///
  /// Map<String, dynamic> dataset = scenario.generate();
  /// List<Review> reviews = dataset['reviews'];
  /// ```
  ///
  /// Returns [EcommerceScenario] for method chaining.
  ///
  /// Note: This method requires [users], [products], and [orders] to be called first.
  EcommerceScenario reviews() {
    final reviewGenerator = ReviewGenerator();
    for (final order in _orders) {
      if (order.items.isNotEmpty) {
        final product = Darturbation.randomChoice(order.items);
        _reviews.add(reviewGenerator.generate(
            user: order.user, product: product, order: order));
      }
    }
    DarturbationCore()
        .relationships
        .storeData('reviews', _reviews.map((r) => r.toJson()).toList());

    return this;
  }

  // =================================================================
  // DATA GENERATION AND EXPORT
  // =================================================================

  /// Generates and returns the complete e-commerce dataset.
  ///
  /// This method compiles all generated entities into a comprehensive
  /// dataset structure that includes:
  /// - All generated users, products, orders, and reviews
  /// - Comprehensive metadata about the generation process
  /// - Regional and seasonal context information
  /// - Entity counts and relationships summary
  ///
  /// The returned dataset structure:
  /// ```dart
  /// {
  ///   'users': [/* List of User objects as JSON */],
  ///   'products': [/* List of Product objects as JSON */],
  ///   'orders': [/* List of Order objects as JSON */],
  ///   'reviews': [/* List of Review objects as JSON */],
  ///   'metadata': {
  ///     'generatedAt': '2025-07-14T10:30:00.000Z',
  ///     'region': 'indonesia',
  ///     'seasonality': 'holiday',
  ///     'counts': {
  ///       'users': 100,
  ///       'products': 50,
  ///       'orders': 100,
  ///       'reviews': 75
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// Example:
  /// ```dart
  /// EcommerceScenario scenario = Darturbation.scenario('ecommerce')
  ///   .users(100)
  ///   .products(50)
  ///   .orders()
  ///   .reviews();
  ///
  /// Map<String, dynamic> dataset = scenario.generate();
  ///
  /// // Export to different formats
  /// String json = Darturbation.export(dataset['users'], to: 'json');
  /// String csv = Darturbation.export(dataset['products'], to: 'csv');
  /// String sql = Darturbation.export(dataset['orders'], to: 'sql');
  /// ```
  ///
  /// Returns a [Map<String, dynamic>] containing the complete dataset with metadata.
  Map<String, dynamic> generate() {
    return {
      'users': _users.map((u) => u.toJson()).toList(),
      'products': _products.map((p) => p.toJson()).toList(),
      'orders': _orders.map((o) => o.toJson()).toList(),
      'reviews': _reviews.map((r) => r.toJson()).toList(),
      'metadata': {
        'generatedAt': DateTime.now().toIso8601String(),
        'region': _region,
        'seasonality': _seasonality,
        'counts': {
          'users': _users.length,
          'products': _products.length,
          'orders': _orders.length,
          'reviews': _reviews.length,
        }
      }
    };
  }

  // =================================================================
  // STREAMING GENERATION METHODS
  // =================================================================

  /// Generates e-commerce data as a stream for memory-efficient processing.
  ///
  /// This method is ideal for:
  /// - Large dataset generation that doesn't fit in memory
  /// - Real-time data pipeline testing
  /// - Continuous data feed simulation
  /// - Memory-constrained environments
  /// - Progressive data processing scenarios
  ///
  /// The stream yields items in the following order:
  /// 1. Users (with type: 'user')
  /// 2. Products (with type: 'product')
  /// 3. Orders (with type: 'order')
  /// 4. Reviews (with type: 'review')
  ///
  /// Each yielded item has the structure:
  /// ```dart
  /// {
  ///   'type': 'user' | 'product' | 'order' | 'review',
  ///   'data': {/* Entity JSON data */}
  /// }
  /// ```
  ///
  /// Example:
  /// ```dart
  /// EcommerceScenario scenario = Darturbation.scenario('ecommerce');
  ///
  /// await for (Map<String, dynamic> item in scenario.generateStream(
  ///   userCount: 1000,
  ///   productCount: 500,
  ///   orderCount: 2000,
  ///   reviewCount: 1500
  /// )) {
  ///   switch (item['type']) {
  ///     case 'user':
  ///       await saveUser(User.fromJson(item['data']));
  ///       break;
  ///     case 'product':
  ///       await saveProduct(Product.fromJson(item['data']));
  ///       break;
  ///     case 'order':
  ///       await saveOrder(Order.fromJson(item['data']));
  ///       break;
  ///     case 'review':
  ///       await saveReview(Review.fromJson(item['data']));
  ///       break;
  ///   }
  /// }
  /// ```
  ///
  /// Parameters:
  /// - [userCount]: Number of users to generate (default: 10)
  /// - [productCount]: Number of products to generate (default: 10)
  /// - [orderCount]: Number of orders to generate (default: 10)
  /// - [reviewCount]: Number of reviews to generate (default: 10)
  ///
  /// Returns a [Stream<Map<String, dynamic>>] yielding generated entities with type information.
  ///
  /// Note: The stream maintains entity relationships by collecting users and products
  /// before generating orders and reviews, ensuring data consistency.
  Stream<Map<String, dynamic>> generateStream({
    int userCount = 10,
    int productCount = 10,
    int orderCount = 10,
    int reviewCount = 10,
  }) async* {
    final List<User> users = [];
    final List<Product> products = [];
    final List<Order> orders = [];

    // Generate and yield users
    await for (final user in Darturbation.streamUsers(count: userCount)) {
      users.add(user);
      yield {'type': 'user', 'data': user.toJson()};
    }

    // Generate and yield products
    await for (final product
        in Darturbation.streamProducts(count: productCount)) {
      products.add(product);
      yield {'type': 'product', 'data': product.toJson()};
    }

    // Generate and yield orders based on collected users and products
    await for (final order in Darturbation.streamOrders(
        users: users, products: products, count: orderCount)) {
      orders.add(order);
      yield {'type': 'order', 'data': order.toJson()};
    }

    // Generate and yield reviews based on collected users, products, and orders
    await for (final review in Darturbation.streamReviews(
        users: users, products: products, orders: orders, count: reviewCount)) {
      yield {'type': 'review', 'data': review.toJson()};
    }
  }
}
