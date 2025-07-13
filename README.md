# 💦Darturbation💦: Advanced Mock Data Generator for Dart & Flutter

[![Dart CI](https://github.com/mathtechstudio/darturbation/actions/workflows/ci.yml/badge.svg)](https://github.com/mathtechstudio/darturbation/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/version-1.0.0+1-blue)](https://pub.dev/packages/darturbation)
[![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue)](https://pub.dev/packages/darturbation)

<!-- ![Darturbation Logo](https://via.placeholder.com/400x200?text=Darturbation+Logo) -->

Darturbation is an advanced mock data generator for Dart and Flutter, focusing on context-aware and behavioral pattern generation. It's designed to overcome the limitations of traditional faker libraries by providing data that is not only random but also realistic and logically interconnected.

## Core Value Proposition

### 1. Indonesian-First Approach

Darturbation is built with a strong focus on Indonesian cultural context, enabling the generation of highly authentic and relevant data:

- **Authentic Indonesian Names:** Generate realistic Indonesian names (e.g., Budi Santoso, Siti Rahayu).
- **Real Addresses:** Produce addresses with real Indonesian cities, provinces, and common street names.
- **Indonesian Phone Numbers:** Generate phone numbers formatted for Indonesia (+62).
- **Cultural Context Awareness:** Data generation considers local nuances and patterns.

### 2. Context-Aware Generation

Beyond simple randomness, Darturbation ensures data is logically interconnected:

- **Related Data:** User emails match names, order dates align with user registration.
- **Behavioral Consistency:** Users with high income are more likely to purchase expensive products.
- **Temporal Relationships:** Order dates and review dates reflect realistic timelines.
- **Geographic Correlation:** Addresses correlate with cities and provinces.

### 3. Behavioral Pattern Simulation

Simulate complex real-world behaviors and trends:

- **Seasonal Trends:** Model seasonal boosts (e.g., Ramadan, Christmas) and slumps.
- **User Behavior Modeling:** Differentiate between power users, casual users, and inactive users.
- **Realistic Distributions:** Apply principles like the Pareto principle for sales data.
- **Time-Based Patterns:** Simulate payday effects and weekend activity.

## Installation

Add Darturbation to your `pubspec.yaml` file:

```yaml
dependencies:
  darturbation: ^1.0.0 # Use the latest version
  # Other dependencies
```

Then, run `dart pub get` in your terminal.

## Basic Usage

Import the package:

```dart
import 'package:darturbation/darturbation.dart';
```

### Generating a Single User

```dart
final user = Darturbation.user();
print('Generated User: ${user.firstName} ${user.lastName}, Email: ${user.email}');
```

### Generating Multiple Products

```dart
final products = Darturbation.products(count: 5);
for (var product in products) {
  print('Product: ${product.name}, Price: ${product.price}');
}
```

### Generating Data from a Custom Schema

```dart
final customSchema = {
  'id': int,
  'first_name': String,
  'last_name': String,
  'email_address': String,
  'is_active': bool,
  'balance': double,
  'registration_date': DateTime,
};

final generatedData = Darturbation.fromSchema(schema: customSchema, count: 3);
print('\nGenerated Data from Schema:');
generatedData.forEach(print);
```

## Advanced Usage: E-commerce Scenario

Darturbation's `EcommerceScenario` allows you to generate interconnected datasets for users, products, orders, and reviews.

```dart
final ecommerceScenario = Darturbation.scenario('indonesian_ecommerce')
  .users(100, region: 'jakarta')
  .products(50, categories: ['electronics', 'fashion'])
  .orders(seasonality: 'ramadan_boost')
  .reviews();

final data = ecommerceScenario.generate();

print('\nE-commerce Scenario Data:');
print('Users: ${data['users'].length}');
print('Products: ${data['products'].length}');
print('Orders: ${data['orders'].length}');
print('Reviews: ${data['reviews'].length}');

// Access specific data
print('\nSample Order:');
print(data['orders'].first.toJson());
```

## Streaming Data Generation (for Large Datasets)

For very large datasets, you can use the streaming API to generate data incrementally, reducing memory footprint.

```dart
import 'package:darturbation/darturbation.dart';

void main() async {
  print('--- Streaming Generated Data (5 users, 5 products, 5 orders, 5 reviews) ---');
  final streamingData = Darturbation.scenario('indonesian_ecommerce').generateStream(
    userCount: 5,
    productCount: 5,
    orderCount: 5,
    reviewCount: 5,
  );

  await for (final dataItem in streamingData) {
    print('Generated ${dataItem['type']}: ${dataItem['data']}');
  }
}
```

## Exporting Data

Darturbation supports various export formats.

### Exporting to JSON

```dart
final usersToExport = Darturbation.users(count: 2);
final jsonOutput = Darturbation.export(usersToExport, to: 'json');
print('\nJSON Export:');
print(jsonOutput);
```

### Exporting to CSV

```dart
final productsToExport = Darturbation.products(count: 2);
final csvOutput = Darturbation.export(productsToExport, to: 'csv');
print('\nCSV Export:');
print(csvOutput);
```

### Exporting to SQL INSERT Statements

```dart
final orders = Darturbation.orders(count: 2, fromUsers: Darturbation.users(count: 2), withProducts: Darturbation.products(count: 2));
final sqlOutput = Darturbation.export(orders, to: 'sql', tableName: 'ecommerce_orders');
print('\nSQL Export:');
print(sqlOutput);
```

## API Reference (Key Classes & Methods)

### `Darturbation` (Static Class)

- `static User user()`: Generates a single `User` object.
- `static List<User> users({int count = 10})`: Generates a list of `User` objects.
- `static Product product()`: Generates a single `Product` object.
- `static List<Product> products({int count = 10})`: Generates a list of `Product` objects.
- `static Order order({required User user, required List<Product> withProducts})`: Generates a single `Order` object.
- `static List<Order> orders({int count = 10, required List<User> fromUsers, required List<Product> withProducts})`: Generates a list of `Order` objects.
- `static List<Map<String, dynamic>> fromSchema({required Map<String, Type> schema, int count = 10})`: Generates data based on a provided schema.
- `static String export<T>(List<T> data, {required String to, String tableName = 'data'})`: Exports a list of data to specified format (json, csv, sql).
- `static EcommerceScenario scenario(String type)`: Entry point for scenario-based generation.
- `static Stream<User> streamUsers({int count = 10})`: Streams `User` objects.
- `static Stream<Product> streamProducts({int count = 10})`: Streams `Product` objects.
- `static Stream<Order> streamOrders({required List<User> users, required List<Product> products, int count = 10})`: Streams `Order` objects.
- `static Stream<Review> streamReviews({required List<User> users, required List<Product> products, required List<Order> orders, int count = 10})`: Streams `Review` objects.
- `static int randomInt(int min, int max)`: Generates a random integer.
- `static double randomDouble(double min, double max)`: Generates a random double.
- `static T randomChoice<T>(List<T> items)`: Selects a random item from a list.
- `static bool randomBool([double probability = 0.5])`: Generates a random boolean.
- `static String generateId()`: Generates a UUID-like ID.

### `EcommerceScenario`

- `EcommerceScenario users(int count, {String? region})`: Configures user generation.
- `EcommerceScenario products(int count, {List<String>? categories})`: Configures product generation.
- `EcommerceScenario orders({String? seasonality})`: Configures order generation.
- `EcommerceScenario reviews()`: Configures review generation.
- `Map<String, dynamic> generate()`: Generates all configured data as lists.
- `Map<String, Stream<dynamic>> generateStream(...)`: Generates all configured data as streams.

### Models (`User`, `Product`, `Order`, `Review`)

These classes represent the generated data entities. Each includes a `toJson()` method for serialization.

## Contributing

We welcome contributions! Please see our [CONTRIBUTING.md](CONTRIBUTING) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
