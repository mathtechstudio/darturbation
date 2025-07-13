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

/// Main Darturbation class - the entry point for all data generation
class Darturbation {
  static final Random _random = Random();
  static final Faker _faker = Faker();
  static final Uuid _uuid = const Uuid();

  // Generators
  static final UserGenerator _userGenerator = UserGenerator();
  static final ProductGenerator _productGenerator = ProductGenerator();
  static final OrderGenerator _orderGenerator = OrderGenerator();
  static final GenericGenerator _genericGenerator = GenericGenerator();
  static final ReviewGenerator _reviewGenerator = ReviewGenerator();

  /// Create a new scenario-based generator
  static EcommerceScenario scenario(String type) {
    switch (type.toLowerCase()) {
      case 'ecommerce':
      case 'indonesian_ecommerce':
        return EcommerceScenario();
      default:
        return EcommerceScenario();
    }
  }

  // Direct data generation methods
  static User user() => _userGenerator.generate();
  static List<User> users({int count = 10}) =>
      List.generate(count, (_) => _userGenerator.generate());
  static Product product() => _productGenerator.generate();
  static List<Product> products({int count = 10}) =>
      List.generate(count, (_) => _productGenerator.generate());
  static Order order(
          {required User user, required List<Product> withProducts}) =>
      _orderGenerator.generate(user: user, withProducts: withProducts);
  static List<Order> orders(
          {int count = 10,
          required List<User> fromUsers,
          required List<Product> withProducts}) =>
      List.generate(
          count,
          (index) => _orderGenerator.generate(
              user: fromUsers[index % fromUsers.length],
              withProducts: withProducts));

  // Streaming data generation methods
  static Stream<User> streamUsers({int count = 10}) =>
      _userGenerator.streamGenerate(count: count);
  static Stream<Product> streamProducts({int count = 10}) =>
      _productGenerator.streamGenerate(count: count);
  static Stream<Order> streamOrders({
    required List<User> users,
    required List<Product> products,
    int count = 10,
  }) =>
      _orderGenerator.streamGenerate(
          users: users, products: products, count: count);
  static Stream<Review> streamReviews({
    required List<User> users,
    required List<Product> products,
    required List<Order> orders,
    int count = 10,
  }) =>
      _reviewGenerator.streamGenerate(
          users: users, products: products, orders: orders, count: count);

  /// Exports a list of data to a specified format.
  static String export<T>(List<T> data,
      {required String to, String tableName = 'data'}) {
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

  /// Generates a list of generic data rows based on a simple schema.
  static List<Map<String, dynamic>> fromSchema(
      {required Map<String, Type> schema, int count = 10}) {
    return List.generate(count, (_) => _genericGenerator.generate(schema));
  }

  // Static utility methods
  /// Generate random integer between min and max (inclusive)
  static int randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }

  /// Generate random double between min and max
  static double randomDouble(double min, double max) {
    return min + _random.nextDouble() * (max - min);
  }

  /// Choose random element from list
  static T randomChoice<T>(List<T> items) {
    return items[_random.nextInt(items.length)];
  }

  /// Generate random boolean with probability
  static bool randomBool([double probability = 0.5]) {
    return _random.nextDouble() < probability;
  }

  /// Generate a v4 UUID string
  static String generateId() {
    return _uuid.v4();
  }
}
