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

// Utils
part 'src/utils/flutter_utils.dart';
part 'src/utils/api_mocker.dart';

// Extensions for Random to support Gaussian distribution
extension RandomExtension on Random {
  /// Generates a normally distributed random number using Box-Muller transform
  double nextGaussian() {
    double u1 = nextDouble();
    double u2 = nextDouble();
    return sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
  }
}

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

  // =================================================================
  // ADVANCED GENERATION METHODS
  // =================================================================

  /// Generates realistic time-series data with configurable trends and seasonality.
  ///
  /// This method creates data points over time with natural variations,
  /// trends, and seasonal patterns that mimic real-world data.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> salesData = Darturbation.timeSeries(
  ///   startDate: DateTime(2023, 1, 1),
  ///   endDate: DateTime(2023, 12, 31),
  ///   interval: Duration(days: 1),
  ///   baseValue: 1000.0,
  ///   trend: 0.1, // 10% upward trend
  ///   seasonality: 0.2, // 20% seasonal variation
  ///   noise: 0.1, // 10% random noise
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [startDate]: Start date for the time series
  /// - [endDate]: End date for the time series
  /// - [interval]: Time interval between data points
  /// - [baseValue]: Base value around which data fluctuates
  /// - [trend]: Trend factor (-1.0 to 1.0, where positive is upward)
  /// - [seasonality]: Seasonal variation factor (0.0 to 1.0)
  /// - [noise]: Random noise factor (0.0 to 1.0)
  ///
  /// Returns a list of maps containing 'timestamp' and 'value' keys.
  static List<Map<String, dynamic>> timeSeries({
    required DateTime startDate,
    required DateTime endDate,
    Duration interval = const Duration(days: 1),
    double baseValue = 100.0,
    double trend = 0.0,
    double seasonality = 0.0,
    double noise = 0.1,
  }) {
    final List<Map<String, dynamic>> result = [];
    DateTime currentDate = startDate;
    int index = 0;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      // Calculate trend component
      final double trendComponent = trend * index;

      // Calculate seasonal component (yearly cycle)
      final double dayOfYear = currentDate
          .difference(DateTime(currentDate.year, 1, 1))
          .inDays
          .toDouble();
      final double seasonalComponent =
          seasonality * baseValue * sin(2 * pi * dayOfYear / 365.25);

      // Add random noise
      final double noiseComponent =
          noise * baseValue * (randomDouble(-1.0, 1.0));

      // Combine all components
      final double value =
          baseValue + trendComponent + seasonalComponent + noiseComponent;

      result.add({
        'timestamp': currentDate.toIso8601String(),
        'value': double.parse(value.toStringAsFixed(2)),
        'date': currentDate,
      });

      currentDate = currentDate.add(interval);
      index++;
    }

    return result;
  }

  /// Generates hierarchical data structures with parent-child relationships.
  ///
  /// This method creates nested data structures like organizational charts,
  /// category trees, or any hierarchical data with realistic relationships.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> orgChart = Darturbation.hierarchical(
  ///   schema: {
  ///     'id': String,
  ///     'name': String,
  ///     'title': String,
  ///     'department': String,
  ///   },
  ///   maxDepth: 4,
  ///   childrenPerNode: [1, 5], // 1-5 children per node
  ///   totalNodes: 100,
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [schema]: Schema definition for each node
  /// - [maxDepth]: Maximum depth of the hierarchy
  /// - [childrenPerNode]: Range of children per node [min, max]
  /// - [totalNodes]: Approximate total number of nodes to generate
  ///
  /// Returns a list of maps representing the hierarchical structure.
  static List<Map<String, dynamic>> hierarchical({
    required Map<String, Type> schema,
    int maxDepth = 3,
    List<int> childrenPerNode = const [2, 5],
    int totalNodes = 50,
  }) {
    final List<Map<String, dynamic>> result = [];
    int nodeCount = 0;

    void generateNode(String? parentId, int depth) {
      if (depth >= maxDepth || nodeCount >= totalNodes) return;

      final node = _genericGenerator.generate(schema);
      node['id'] = generateId();
      node['parentId'] = parentId;
      node['depth'] = depth;
      node['children'] = <Map<String, dynamic>>[];

      result.add(node);
      nodeCount++;

      if (depth < maxDepth - 1 && nodeCount < totalNodes) {
        final childCount = randomInt(childrenPerNode[0], childrenPerNode[1]);
        for (int i = 0; i < childCount && nodeCount < totalNodes; i++) {
          generateNode(node['id'], depth + 1);
        }
      }
    }

    // Generate root nodes
    final rootCount = (totalNodes * 0.1).ceil().clamp(1, 5);
    for (int i = 0; i < rootCount && nodeCount < totalNodes; i++) {
      generateNode(null, 0);
    }

    // Build parent-child relationships
    final Map<String, Map<String, dynamic>> nodeMap = {
      for (var node in result) node['id']: node
    };
    for (var node in result) {
      if (node['parentId'] != null) {
        final parent = nodeMap[node['parentId']];
        if (parent != null) {
          (parent['children'] as List).add(node);
        }
      }
    }

    return result;
  }

  /// Generates realistic graph data with nodes and edges.
  ///
  /// Creates graph structures suitable for social networks, dependency graphs,
  /// or any connected data visualization.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> socialNetwork = Darturbation.graph(
  ///   nodeCount: 100,
  ///   nodeSchema: {
  ///     'name': String,
  ///     'age': int,
  ///     'location': String,
  ///   },
  ///   connectionProbability: 0.1, // 10% chance of connection between any two nodes
  ///   directed: false,
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [nodeCount]: Number of nodes to generate
  /// - [nodeSchema]: Schema for node attributes
  /// - [connectionProbability]: Probability of connection between nodes (0.0-1.0)
  /// - [directed]: Whether the graph is directed
  /// - [minDegree]: Minimum connections per node
  /// - [maxDegree]: Maximum connections per node
  ///
  /// Returns a map with 'nodes' and 'edges' keys.
  static Map<String, dynamic> graph({
    int nodeCount = 50,
    Map<String, Type> nodeSchema = const {'name': String, 'value': int},
    double connectionProbability = 0.1,
    bool directed = false,
    int minDegree = 1,
    int maxDegree = 10,
  }) {
    // Generate nodes
    final List<Map<String, dynamic>> nodes = [];
    for (int i = 0; i < nodeCount; i++) {
      final node = _genericGenerator.generate(nodeSchema);
      node['id'] = generateId();
      node['index'] = i;
      nodes.add(node);
    }

    // Generate edges
    final List<Map<String, dynamic>> edges = [];
    final Set<String> edgeSet = {};

    for (int i = 0; i < nodeCount; i++) {
      final sourceNode = nodes[i];
      int degree = 0;

      for (int j = 0; j < nodeCount; j++) {
        if (i == j || degree >= maxDegree) continue;

        final targetNode = nodes[j];
        final List<String> nodeIds = [
          sourceNode['id'].toString(),
          targetNode['id'].toString()
        ];
        final edgeKey = directed
            ? '${sourceNode['id']}->${targetNode['id']}'
            : (nodeIds..sort()).join('-');

        if (!edgeSet.contains(edgeKey) && randomBool(connectionProbability)) {
          edges.add({
            'id': generateId(),
            'source': sourceNode['id'],
            'target': targetNode['id'],
            'weight': randomDouble(0.1, 1.0),
            'directed': directed,
          });
          edgeSet.add(edgeKey);
          degree++;
        }
      }

      // Ensure minimum degree
      while (degree < minDegree && edges.length < nodeCount * maxDegree) {
        final targetIndex = randomInt(0, nodeCount - 1);
        if (targetIndex == i) continue;

        final targetNode = nodes[targetIndex];
        final List<String> nodeIds = [
          sourceNode['id'].toString(),
          targetNode['id'].toString()
        ];
        final edgeKey = directed
            ? '${sourceNode['id']}->${targetNode['id']}'
            : (nodeIds..sort()).join('-');

        if (!edgeSet.contains(edgeKey)) {
          edges.add({
            'id': generateId(),
            'source': sourceNode['id'],
            'target': targetNode['id'],
            'weight': randomDouble(0.1, 1.0),
            'directed': directed,
          });
          edgeSet.add(edgeKey);
          degree++;
        }
      }
    }

    return {
      'nodes': nodes,
      'edges': edges,
      'metadata': {
        'nodeCount': nodes.length,
        'edgeCount': edges.length,
        'directed': directed,
        'averageDegree': edges.length * (directed ? 1 : 2) / nodes.length,
      },
    };
  }

  /// Generates correlated data sets with configurable correlation strength.
  ///
  /// Creates multiple data series where values are mathematically correlated,
  /// useful for testing analytics and machine learning algorithms.
  ///
  /// Example:
  /// ```dart
  /// Map<String, List<double>> correlatedData = Darturbation.correlatedSeries(
  ///   seriesNames: ['temperature', 'ice_cream_sales', 'beach_visitors'],
  ///   correlationMatrix: [
  ///     [1.0, 0.8, 0.7],   // temperature correlations
  ///     [0.8, 1.0, 0.6],   // ice_cream_sales correlations
  ///     [0.7, 0.6, 1.0],   // beach_visitors correlations
  ///   ],
  ///   count: 365,
  ///   means: [25.0, 100.0, 50.0],
  ///   standardDeviations: [10.0, 30.0, 20.0],
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [seriesNames]: Names of the data series
  /// - [correlationMatrix]: Correlation matrix (must be symmetric)
  /// - [count]: Number of data points per series
  /// - [means]: Mean values for each series
  /// - [standardDeviations]: Standard deviations for each series
  ///
  /// Returns a map with series names as keys and data lists as values.
  static Map<String, List<double>> correlatedSeries({
    required List<String> seriesNames,
    required List<List<double>> correlationMatrix,
    int count = 100,
    List<double>? means,
    List<double>? standardDeviations,
  }) {
    if (seriesNames.length != correlationMatrix.length) {
      throw ArgumentError(
          'Series names count must match correlation matrix size');
    }

    final int seriesCount = seriesNames.length;
    final List<double> actualMeans = means ?? List.filled(seriesCount, 0.0);
    final List<double> actualStdDevs =
        standardDeviations ?? List.filled(seriesCount, 1.0);

    final Map<String, List<double>> result = {};
    for (String name in seriesNames) {
      result[name] = [];
    }

    // Generate correlated data using Cholesky decomposition approach (simplified)
    for (int i = 0; i < count; i++) {
      final List<double> independent = [];
      for (int j = 0; j < seriesCount; j++) {
        independent.add(_random.nextGaussian());
      }

      for (int j = 0; j < seriesCount; j++) {
        double value = 0.0;

        // Apply correlation (simplified approach)
        for (int k = 0; k <= j; k++) {
          final correlation = k == j ? 1.0 : correlationMatrix[j][k];
          value += correlation * independent[k];
        }

        // Scale and shift to desired mean and standard deviation
        value = actualMeans[j] + value * actualStdDevs[j] / sqrt(j + 1);
        result[seriesNames[j]]!.add(double.parse(value.toStringAsFixed(3)));
      }
    }

    return result;
  }

  /// Generates synthetic data with realistic outliers and anomalies.
  ///
  /// Creates datasets with intentional outliers for testing anomaly detection
  /// algorithms and data validation systems.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> dataset = Darturbation.withAnomalies(
  ///   schema: {
  ///     'value': double,
  ///     'category': String,
  ///     'timestamp': DateTime,
  ///   },
  ///   count: 1000,
  ///   anomalyRate: 0.05, // 5% anomalies
  ///   anomalyTypes: ['extreme_values', 'missing_data', 'inconsistent_patterns'],
  /// );
  /// ```
  ///
  /// Parameters:
  /// - [schema]: Data schema definition
  /// - [count]: Total number of records
  /// - [anomalyRate]: Proportion of anomalous records (0.0-1.0)
  /// - [anomalyTypes]: Types of anomalies to introduce
  ///
  /// Returns a list of maps with 'data', 'isAnomaly', and 'anomalyType' keys.
  static List<Map<String, dynamic>> withAnomalies({
    required Map<String, Type> schema,
    int count = 100,
    double anomalyRate = 0.1,
    List<String> anomalyTypes = const ['extreme_values', 'missing_data'],
  }) {
    final List<Map<String, dynamic>> result = [];
    final int anomalyCount = (count * anomalyRate).round();
    final Set<int> anomalyIndices = {};

    // Select random indices for anomalies
    while (anomalyIndices.length < anomalyCount) {
      anomalyIndices.add(randomInt(0, count - 1));
    }

    for (int i = 0; i < count; i++) {
      Map<String, dynamic> record = _genericGenerator.generate(schema);
      bool isAnomaly = anomalyIndices.contains(i);
      String? anomalyType;

      if (isAnomaly) {
        anomalyType = randomChoice(anomalyTypes);

        switch (anomalyType) {
          case 'extreme_values':
            // Make numeric values extremely high or low
            record.forEach((key, value) {
              if (value is double) {
                record[key] = randomBool() ? value * 10 : value / 10;
              } else if (value is int) {
                record[key] = randomBool() ? value * 10 : (value / 10).round();
              }
            });
            break;

          case 'missing_data':
            // Set some fields to null
            final keysToNull = randomChoice(record.keys.toList());
            record[keysToNull] = null;
            break;

          case 'inconsistent_patterns':
            // Introduce inconsistent data patterns
            record.forEach((key, value) {
              if (value is String && key.toLowerCase().contains('email')) {
                record[key] = 'invalid-email-format';
              } else if (value is DateTime) {
                record[key] = DateTime(1900, 1, 1); // Unrealistic date
              }
            });
            break;
        }
      }

      result.add({
        'data': record,
        'isAnomaly': isAnomaly,
        'anomalyType': anomalyType,
        'index': i,
      });
    }

    return result;
  }

  // =================================================================
  // FLUTTER-SPECIFIC METHODS
  // =================================================================

  /// Generates mock data optimized for Flutter ListView widgets.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> listData = Darturbation.listView(
  ///   itemCount: 50,
  ///   itemType: 'user_profile',
  /// );
  /// ```
  static List<Map<String, dynamic>> listView({
    int itemCount = 20,
    String itemType = 'generic',
    Map<String, Type>? customSchema,
  }) {
    final schema = customSchema ?? _getSchemaForType(itemType);
    return FlutterUtils.listViewData(
      itemCount: itemCount,
      itemSchema: schema,
    );
  }

  /// Generates mock data for Flutter Card widgets.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> cards = Darturbation.cards(
  ///   cardCount: 10,
  ///   cardType: 'product',
  /// );
  /// ```
  static List<Map<String, dynamic>> cards({
    int cardCount = 10,
    String cardType = 'generic',
  }) {
    return FlutterUtils.cardData(
      cardCount: cardCount,
      cardType: cardType,
    );
  }

  /// Generates mock form data for Flutter form widgets.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> form = Darturbation.form(
  ///   formType: 'registration',
  ///   includeValidation: true,
  /// );
  /// ```
  static Map<String, dynamic> form({
    String formType = 'generic',
    bool includeValidation = true,
  }) {
    return FlutterUtils.formData(
      formType: formType,
      includeValidation: includeValidation,
    );
  }

  /// Generates mock navigation data for Flutter routing.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> navigation = Darturbation.navigation(
  ///   routeCount: 15,
  /// );
  /// ```
  static Map<String, dynamic> navigation({
    int routeCount = 10,
    bool includeHistory = true,
  }) {
    return FlutterUtils.navigationData(
      routeCount: routeCount,
      includeHistory: includeHistory,
    );
  }

  /// Generates Flutter theme data.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> theme = Darturbation.theme(
  ///   isDark: true,
  /// );
  /// ```
  static Map<String, dynamic> theme({
    String themeName = 'default',
    bool isDark = false,
  }) {
    return FlutterUtils.themeData(
      themeName: themeName,
      isDark: isDark,
    );
  }

  // =================================================================
  // API MOCKING METHODS
  // =================================================================

  /// Generates mock REST API responses.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> apiResponse = Darturbation.apiResponse(
  ///   endpoint: '/api/users',
  ///   method: 'GET',
  ///   itemCount: 25,
  /// );
  /// ```
  static Map<String, dynamic> apiResponse({
    required String endpoint,
    String method = 'GET',
    Map<String, Type>? dataSchema,
    int itemCount = 10,
    int statusCode = 200,
  }) {
    return ApiMocker.restResponse(
      endpoint: endpoint,
      method: method,
      dataSchema: dataSchema ?? {'id': String, 'name': String, 'email': String},
      itemCount: itemCount,
      statusCode: statusCode,
    );
  }

  /// Generates mock GraphQL responses.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> gqlResponse = Darturbation.graphqlResponse(
  ///   query: 'query GetUsers { users { id name } }',
  ///   dataSchema: {'users': List},
  /// );
  /// ```
  static Map<String, dynamic> graphqlResponse({
    required String query,
    Map<String, Type> dataSchema = const {},
    int itemCount = 10,
  }) {
    return ApiMocker.graphqlResponse(
      query: query,
      dataSchema: dataSchema,
      itemCount: itemCount,
    );
  }

  /// Generates mock WebSocket messages.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> wsMessage = Darturbation.websocketMessage(
  ///   type: 'chat_message',
  ///   dataSchema: {'userId': String, 'message': String},
  /// );
  /// ```
  static Map<String, dynamic> websocketMessage({
    required String type,
    Map<String, Type> dataSchema = const {},
  }) {
    return ApiMocker.websocketMessage(
      type: type,
      dataSchema: dataSchema,
    );
  }

  /// Generates mock error responses.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> error = Darturbation.errorResponse(
  ///   statusCode: 404,
  /// );
  /// ```
  static Map<String, dynamic> errorResponse({
    int statusCode = 500,
    String? message,
  }) {
    return ApiMocker.errorResponse(
      statusCode: statusCode,
      message: message,
    );
  }

  // =================================================================
  // HELPER METHODS
  // =================================================================

  /// Gets predefined schema for common data types.
  static Map<String, Type> _getSchemaForType(String type) {
    switch (type.toLowerCase()) {
      case 'user_profile':
        return {
          'id': String,
          'firstName': String,
          'lastName': String,
          'email': String,
          'avatarUrl': String,
          'bio': String,
          'joinedDate': DateTime,
          'isActive': bool,
        };
      case 'product':
        return {
          'id': String,
          'name': String,
          'description': String,
          'price': double,
          'currency': String,
          'imageUrl': String,
          'category': String,
          'inStock': bool,
          'rating': double,
        };
      case 'article':
        return {
          'id': String,
          'title': String,
          'excerpt': String,
          'author': String,
          'publishDate': DateTime,
          'readTime': String,
          'imageUrl': String,
          'category': String,
          'viewCount': int,
        };
      case 'message':
        return {
          'id': String,
          'senderId': String,
          'content': String,
          'timestamp': DateTime,
          'isRead': bool,
          'messageType': String,
        };
      case 'notification':
        return {
          'id': String,
          'title': String,
          'message': String,
          'timestamp': DateTime,
          'isRead': bool,
          'priority': String,
          'actionUrl': String,
        };
      default:
        return {
          'id': String,
          'title': String,
          'description': String,
          'value': double,
          'status': String,
          'createdAt': DateTime,
        };
    }
  }
}
