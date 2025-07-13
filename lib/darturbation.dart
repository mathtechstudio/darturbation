import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

// Core files
part 'src/core/context_manager.dart';
part 'src/core/darturbation_core.dart';
part 'src/core/generic_generator.dart';
part 'src/core/pattern_engine.dart';
part 'src/core/relationship_manager.dart';

// Data files
part 'src/data/behavioral_patterns.dart';
part 'src/data/indonesian_data.dart';
part 'src/data/product_data.dart';

// Exporters
part 'src/exporters/csv_exporter.dart';
part 'src/exporters/exporter_base.dart';
part 'src/exporters/json_exporter.dart';
part 'src/exporters/sql_exporter.dart';

// Generators
part 'src/generators/order_generator.dart';
part 'src/generators/product_generator.dart';
part 'src/generators/user_generator.dart';
part 'src/generators/review_generator.dart';

// Models
part 'src/models/order_model.dart';
part 'src/models/product_model.dart';
part 'src/models/review_model.dart';
part 'src/models/user_model.dart';

// Scenarios
part 'src/scenarios/ecommerce_scenario.dart';

/// Darturbation is an advanced mock data generator for Dart and Flutter applications.
///
/// This library focuses on context-aware and behavioral pattern generation,
/// providing realistic and logically interconnected data rather than just random values.
/// It's designed to overcome the limitations of traditional faker libraries by
/// generating data that maintains relationships and follows realistic patterns.
///
/// ## Features
/// - Context-aware data generation
/// - Behavioral pattern recognition
/// - Realistic relationship management
/// - Multiple export formats (CSV, JSON, SQL)
/// - Streaming data generation
/// - Indonesian localization support
/// - E-commerce scenario templates
///
/// ## Basic Usage
/// ```dart
/// // Generate single entities
/// User user = Darturbation.user();
/// Product product = Darturbation.product();
///
/// // Generate multiple entities
/// List<User> users = Darturbation.users(count: 100);
/// List<Product> products = Darturbation.products(count: 50);
///
/// // Generate related data
/// Order order = Darturbation.order(user: user, withProducts: [product]);
///
/// // Use scenario-based generation
/// EcommerceScenario scenario = Darturbation.scenario('ecommerce');
/// ```
///
/// ## Streaming Generation
/// ```dart
/// // Generate data as streams for large datasets
/// Stream<User> userStream = Darturbation.streamUsers(count: 1000);
/// Stream<Product> productStream = Darturbation.streamProducts(count: 500);
/// ```
///
/// ## Data Export
/// ```dart
/// List<User> users = Darturbation.users(count: 100);
/// String csvData = Darturbation.export(users, to: 'csv');
/// String jsonData = Darturbation.export(users, to: 'json');
/// String sqlData = Darturbation.export(users, to: 'sql', tableName: 'users');
/// ```
class Darturbation {
  // Private static instances for internal use
  static final Random _random = Random();
  static final Faker _faker = Faker();
  static final Uuid _uuid = const Uuid();

  // Generator instances for different data types
  static final UserGenerator _userGenerator = UserGenerator();
  static final ProductGenerator _productGenerator = ProductGenerator();
  static final OrderGenerator _orderGenerator = OrderGenerator();
  static final GenericGenerator _genericGenerator = GenericGenerator();
  static final ReviewGenerator _reviewGenerator = ReviewGenerator();

  /// Creates a new scenario-based generator for specific use cases.
  ///
  /// Scenarios provide pre-configured templates for common data generation patterns.
  /// Currently supported scenarios:
  /// - `'ecommerce'` or `'indonesian_ecommerce'`: E-commerce platform data
  ///
  /// ## Example
  /// ```dart
  /// EcommerceScenario scenario = Darturbation.scenario('ecommerce');
  /// var data = scenario.generateCompleteDataset(
  ///   userCount: 100,
  ///   productCount: 50,
  ///   orderCount: 200
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [type]: The scenario type identifier
  ///
  /// Returns an [EcommerceScenario] instance configured for the specified type.
  static EcommerceScenario scenario(String type) {
    switch (type.toLowerCase()) {
      case 'ecommerce':
      case 'indonesian_ecommerce':
        return EcommerceScenario();
      default:
        return EcommerceScenario();
    }
  }

  // =================================================================
  // SINGLE ENTITY GENERATION METHODS
  // =================================================================

  /// Generates a single [User] with realistic profile data.
  ///
  /// The generated user includes:
  /// - Realistic name combinations
  /// - Valid email addresses
  /// - Phone numbers with proper formatting
  /// - Addresses with geographic consistency
  /// - Age-appropriate demographic data
  ///
  /// Example:
  /// ```dart
  /// User user = Darturbation.user();
  /// print('${user.firstName} - ${user.email}');
  /// ```
  ///
  /// Returns a [User] instance with generated profile data.
  static User user() => _userGenerator.generate();

  /// Generates a single [Product] with market-realistic attributes.
  ///
  /// The generated product includes:
  /// - Category-appropriate names and descriptions
  /// - Realistic pricing based on product type
  /// - Proper SKU formatting
  /// - Inventory levels that make business sense
  /// - Ratings and review counts with realistic distributions
  ///
  /// Example:
  /// ```dart
  /// Product product = Darturbation.product();
  /// print('${product.name} - \$${product.price}');
  /// ```
  ///
  /// Returns a [Product] instance with generated market data.
  static Product product() => _productGenerator.generate();

  /// Generates a single [Order] with relationship-aware data.
  ///
  /// The order maintains logical relationships between:
  /// - User demographics and purchasing behavior
  /// - Product combinations and quantities
  /// - Pricing calculations and totals
  /// - Shipping addresses and user locations
  /// - Order timing and seasonal patterns
  ///
  /// Example:
  /// ```dart
  /// User user = Darturbation.user();
  /// List<Product> products = Darturbation.products(count: 3);
  /// Order order = Darturbation.order(user: user, withProducts: products);
  /// ```
  ///
  /// Parameters:
  /// - [user]: The user placing the order
  /// - [withProducts]: List of products to include in the order
  ///
  /// Returns an [Order] instance with calculated totals and relationships.
  static Order order(
          {required User user, required List<Product> withProducts}) =>
      _orderGenerator.generate(user: user, withProducts: withProducts);

  // =================================================================
  // BULK GENERATION METHODS
  // =================================================================

  /// Generates multiple [User] instances with diverse but realistic profiles.
  ///
  /// The generated users maintain demographic diversity while ensuring
  /// realistic distributions across age groups, locations, and preferences.
  ///
  /// Example:
  /// ```dart
  /// List<User> users = Darturbation.users(count: 100);
  /// print('Generated ${users.length} users');
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of users to generate (default: 10)
  ///
  /// Returns a [List<User>] with the specified number of generated users.
  static List<User> users({int count = 10}) =>
      List.generate(count, (_) => _userGenerator.generate());

  /// Generates multiple [Product] instances across various categories.
  ///
  /// The generated products ensure:
  /// - Balanced distribution across categories
  /// - Realistic price ranges per category
  /// - Varied but market-appropriate attributes
  /// - Diverse inventory levels and availability
  ///
  /// Example:
  /// ```dart
  /// List<Product> products = Darturbation.products(count: 50);
  /// var electronics = products.where((p) => p.category == 'Electronics');
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of products to generate (default: 10)
  ///
  /// Returns a [List<Product>] with the specified number of generated products.
  static List<Product> products({int count = 10}) =>
      List.generate(count, (_) => _productGenerator.generate());

  /// Generates multiple [Order] instances with realistic purchasing patterns.
  ///
  /// The generated orders maintain:
  /// - User-specific purchasing behavior
  /// - Seasonal and temporal patterns
  /// - Realistic product combinations
  /// - Proper order value distributions
  ///
  /// Example:
  /// ```dart
  /// List<User> users = Darturbation.users(count: 20);
  /// List<Product> products = Darturbation.products(count: 100);
  /// List<Order> orders = Darturbation.orders(
  ///   count: 50,
  ///   fromUsers: users,
  ///   withProducts: products
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of orders to generate (default: 10)
  /// - [fromUsers]: List of users who can place orders
  /// - [withProducts]: List of available products for ordering
  ///
  /// Returns a [List<Order>] with relationship-aware order data.
  static List<Order> orders({
    int count = 10,
    required List<User> fromUsers,
    required List<Product> withProducts,
  }) =>
      List.generate(
          count,
          (index) => _orderGenerator.generate(
              user: fromUsers[index % fromUsers.length],
              withProducts: withProducts));

  // =================================================================
  // STREAMING GENERATION METHODS
  // =================================================================

  /// Generates a stream of [User] instances for memory-efficient bulk processing.
  ///
  /// Streaming generation is ideal for:
  /// - Large datasets that don't fit in memory
  /// - Real-time data processing scenarios
  /// - Continuous data feed simulation
  /// - Memory-constrained environments
  ///
  /// Example:
  /// ```dart
  /// Stream<User> userStream = Darturbation.streamUsers(count: 10000);
  /// await for (User user in userStream) {
  ///   // Process each user individually
  ///   await processUser(user);
  /// }
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of users to generate in the stream (default: 10)
  ///
  /// Returns a [Stream<User>] that yields generated users one by one.
  static Stream<User> streamUsers({int count = 10}) =>
      _userGenerator.streamGenerate(count: count);

  /// Generates a stream of [Product] instances for efficient bulk processing.
  ///
  /// Useful for scenarios requiring:
  /// - Large product catalog generation
  /// - Continuous inventory simulation
  /// - Memory-efficient data processing
  /// - Real-time product feed testing
  ///
  /// Example:
  /// ```dart
  /// Stream<Product> productStream = Darturbation.streamProducts(count: 5000);
  /// await productStream.forEach((product) {
  ///   catalog.add(product);
  /// });
  /// ```
  ///
  /// Parameters:
  /// - [count]: Number of products to generate in the stream (default: 10)
  ///
  /// Returns a [Stream<Product>] that yields generated products sequentially.
  static Stream<Product> streamProducts({int count = 10}) =>
      _productGenerator.streamGenerate(count: count);

  /// Generates a stream of [Order] instances with maintained relationships.
  ///
  /// The streaming order generation ensures:
  /// - Consistent user-product relationships
  /// - Realistic ordering patterns over time
  /// - Memory-efficient processing of large order volumes
  /// - Proper distribution of orders across users
  ///
  /// Example:
  /// ```dart
  /// List<User> users = Darturbation.users(count: 100);
  /// List<Product> products = Darturbation.products(count: 500);
  ///
  /// Stream<Order> orderStream = Darturbation.streamOrders(
  ///   users: users,
  ///   products: products,
  ///   count: 10000
  /// );
  ///
  /// await for (Order order in orderStream) {
  ///   await saveOrderToDatabase(order);
  /// }
  /// ```
  ///
  /// Parameters:
  /// - [users]: List of users who can place orders
  /// - [products]: List of available products for ordering
  /// - [count]: Number of orders to generate in the stream (default: 10)
  ///
  /// Returns a [Stream<Order>] with relationship-aware order data.
  static Stream<Order> streamOrders({
    required List<User> users,
    required List<Product> products,
    int count = 10,
  }) =>
      _orderGenerator.streamGenerate(
          users: users, products: products, count: count);

  /// Generates a stream of [Review] instances with realistic rating patterns.
  ///
  /// The review generation considers:
  /// - User purchase history and preferences
  /// - Product quality and category patterns
  /// - Realistic review timing after orders
  /// - Natural language variation in review content
  ///
  /// Example:
  /// ```dart
  /// List<User> users = Darturbation.users(count: 50);
  /// List<Product> products = Darturbation.products(count: 200);
  /// List<Order> orders = Darturbation.orders(
  ///   count: 100,
  ///   fromUsers: users,
  ///   withProducts: products
  /// );
  ///
  /// Stream<Review> reviewStream = Darturbation.streamReviews(
  ///   users: users,
  ///   products: products,
  ///   orders: orders,
  ///   count: 300
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [users]: List of users who can write reviews
  /// - [products]: List of products that can be reviewed
  /// - [orders]: List of orders that reviews are based on
  /// - [count]: Number of reviews to generate in the stream (default: 10)
  ///
  /// Returns a [Stream<Review>] with contextually appropriate review data.
  static Stream<Review> streamReviews({
    required List<User> users,
    required List<Product> products,
    required List<Order> orders,
    int count = 10,
  }) =>
      _reviewGenerator.streamGenerate(
          users: users, products: products, orders: orders, count: count);

  // =================================================================
  // DATA EXPORT METHODS
  // =================================================================

  /// Exports a list of generated data to various formats.
  ///
  /// Supported export formats:
  /// - `'csv'`: Comma-separated values with proper escaping
  /// - `'json'`: Pretty-formatted JSON with consistent structure
  /// - `'sql'`: INSERT statements ready for database import
  ///
  /// The export process automatically handles:
  /// - Data type conversion and formatting
  /// - Null value handling
  /// - Special character escaping
  /// - Consistent column ordering
  ///
  /// Example:
  /// ```dart
  /// List<User> users = Darturbation.users(count: 100);
  ///
  /// // Export to CSV
  /// String csvData = Darturbation.export(users, to: 'csv');
  /// File('users.csv').writeAsStringSync(csvData);
  ///
  /// // Export to SQL
  /// String sqlData = Darturbation.export(
  ///   users,
  ///   to: 'sql',
  ///   tableName: 'app_users'
  /// );
  /// File('users.sql').writeAsStringSync(sqlData);
  ///
  /// // Export to JSON
  /// String jsonData = Darturbation.export(users, to: 'json');
  /// File('users.json').writeAsStringSync(jsonData);
  /// ```
  ///
  /// Parameters:
  /// - [data]: List of objects to export (must have toJson() method)
  /// - [to]: Export format ('csv', 'json', or 'sql')
  /// - [tableName]: Table name for SQL exports (default: 'data')
  ///
  /// Returns a [String] containing the formatted export data.
  ///
  /// Throws [ArgumentError] if an unsupported export format is specified.
  static String export<T>(
    List<T> data, {
    required String to,
    String tableName = 'data',
  }) {
    switch (to.toLowerCase()) {
      case 'csv':
        return CsvExporter().export(data
            .map((e) => (e as dynamic).toJson())
            .toList()
            .cast<Map<String, dynamic>>());
      case 'sql':
        return SqlExporter(tableName: tableName).export(data
            .map((e) => (e as dynamic).toJson())
            .toList()
            .cast<Map<String, dynamic>>());
      case 'json':
        return JsonExporter().export(data
            .map((e) => (e as dynamic).toJson())
            .toList()
            .cast<Map<String, dynamic>>());
      default:
        throw ArgumentError('Unsupported export format: $to');
    }
  }

  // =================================================================
  // SCHEMA-BASED GENERATION
  // =================================================================

  /// Generates generic data based on a custom schema definition.
  ///
  /// This method allows for flexible data generation when you need
  /// custom data structures that don't fit the predefined models.
  ///
  /// Supported schema types:
  /// - `String`: Random text generation
  /// - `int`: Random integer values
  /// - `double`: Random decimal values
  /// - `bool`: Random boolean values
  /// - `DateTime`: Random date/time values
  ///
  /// Example:
  /// ```dart
  /// Map<String, Type> schema = {
  ///   'name': String,
  ///   'age': int,
  ///   'salary': double,
  ///   'isActive': bool,
  ///   'createdAt': DateTime,
  /// };
  ///
  /// List<Map<String, dynamic>> data = Darturbation.fromSchema(
  ///   schema: schema,
  ///   count: 100
  /// );
  ///
  /// // Export the custom data
  /// String csvData = Darturbation.export(data, to: 'csv');
  /// ```
  ///
  /// Parameters:
  /// - [schema]: Map defining field names and their data types
  /// - [count]: Number of data rows to generate (default: 10)
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the generated data.
  static List<Map<String, dynamic>> fromSchema({
    required Map<String, Type> schema,
    int count = 10,
  }) {
    return List.generate(count, (_) => _genericGenerator.generate(schema));
  }

  // =================================================================
  // UTILITY METHODS
  // =================================================================

  /// Generates a random integer between min and max (inclusive).
  ///
  /// This utility method provides consistent random integer generation
  /// across all Darturbation components.
  ///
  /// Example:
  /// ```dart
  /// int randomAge = Darturbation.randomInt(18, 65);
  /// int diceRoll = Darturbation.randomInt(1, 6);
  /// ```
  ///
  /// Parameters:
  /// - [min]: Minimum value (inclusive)
  /// - [max]: Maximum value (inclusive)
  ///
  /// Returns a random integer within the specified range.
  static int randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }

  /// Generates a random double between min and max.
  ///
  /// Useful for generating decimal values like prices, ratings, or percentages.
  ///
  /// Example:
  /// ```dart
  /// double price = Darturbation.randomDouble(10.0, 999.99);
  /// double rating = Darturbation.randomDouble(1.0, 5.0);
  /// ```
  ///
  /// Parameters:
  /// - [min]: Minimum value (inclusive)
  /// - [max]: Maximum value (exclusive)
  ///
  /// Returns a random double within the specified range.
  static double randomDouble(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }

  /// Selects a random element from a list.
  ///
  /// This method provides type-safe random selection from any list.
  ///
  /// Example:
  /// ```dart
  /// List<String> colors = ['red', 'blue', 'green', 'yellow'];
  /// String randomColor = Darturbation.randomChoice(colors);
  ///
  /// List<int> numbers = [1, 2, 3, 4, 5];
  /// int randomNumber = Darturbation.randomChoice(numbers);
  /// ```
  ///
  /// Parameters:
  /// - [items]: List of items to choose from
  ///
  /// Returns a random element from the provided list.
  ///
  /// Throws [RangeError] if the list is empty.
  static T randomChoice<T>(List<T> items) {
    return items[_random.nextInt(items.length)];
  }

  /// Generates a random boolean value with configurable probability.
  ///
  /// This method allows for weighted boolean generation, useful for
  /// simulating real-world scenarios where outcomes aren't always 50/50.
  ///
  /// Example:
  /// ```dart
  /// bool coinFlip = Darturbation.randomBool(); // 50% chance
  /// bool rareEvent = Darturbation.randomBool(0.1); // 10% chance
  /// bool commonEvent = Darturbation.randomBool(0.8); // 80% chance
  /// ```
  ///
  /// Parameters:
  /// - [probability]: Probability of returning true (default: 0.5)
  ///
  /// Returns true with the specified probability, false otherwise.
  static bool randomBool([double probability = 0.5]) {
    return _random.nextDouble() < probability;
  }

  /// Generates a Version 4 UUID string.
  ///
  /// UUIDs are useful for creating unique identifiers that can be
  /// safely used across distributed systems without collision concerns.
  ///
  /// Example:
  /// ```dart
  /// String userId = Darturbation.generateId();
  /// String orderId = Darturbation.generateId();
  /// String sessionId = Darturbation.generateId();
  /// ```
  ///
  /// Returns a randomly generated UUID v4 string.
  static String generateId() {
    return _uuid.v4();
  }
}
