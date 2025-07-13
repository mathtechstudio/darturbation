import 'package:darturbation/darturbation.dart';

void main() async {
  print('# Darturbation Example Scenarios\n');

  // --- Basic Usage ---
  print('## Basic Usage\n');

  // Generate a single user
  final user = Darturbation.user();
  print(
      'Generated User: ${user.firstName} ${user.lastName}, Email: ${user.email}\n');

  // Generate multiple products
  final products = Darturbation.products(count: 2);
  print('Generated Products:');
  for (var product in products) {
    print('- ${product.name}, Price: ${product.price}');
  }
  print('\n');

  // --- Schema-based Generation ---
  print('## Schema-based Generation\n');
  final customSchema = {
    'id': int,
    'first_name': String,
    'last_name': String,
    'email_address': String,
    'is_active': bool,
    'balance': double,
    'registration_date': DateTime,
  };

  final generatedSchemaData =
      Darturbation.fromSchema(schema: customSchema, count: 2);
  print('Generated Data from Custom Schema:');
  generatedSchemaData.forEach(print);
  print('\n');

  // --- E-commerce Scenario (Non-Streaming) ---
  print('## E-commerce Scenario (Non-Streaming)\n');
  final ecommerceData = Darturbation.scenario('indonesian_ecommerce')
      .users(5, region: 'jakarta')
      .products(5, categories: ['electronics', 'fashion'])
      .orders(seasonality: 'ramadan_boost')
      .reviews()
      .generate();

  print('Generated E-commerce Data Summary:');
  print('- Users: ${ecommerceData['users'].length}');
  print('- Products: ${ecommerceData['products'].length}');
  print('- Orders: ${ecommerceData['orders'].length}');
  print('- Reviews: ${ecommerceData['reviews'].length}');
  print(
      '\nSample User (from E-commerce Scenario): ${ecommerceData['users'].first.toJson()}\n');

  // --- Streaming Data Generation ---
  print('## Streaming Data Generation\n');
  print('Generating 3 users, 3 products, 3 orders, 3 reviews via streaming...');
  final streamingData =
      Darturbation.scenario('indonesian_ecommerce').generateStream(
    userCount: 3,
    productCount: 3,
    orderCount: 3,
    reviewCount: 3,
  );

  await for (final dataItem in streamingData) {
    print('Streamed ${dataItem['type']}: ${dataItem['data']}');
  }
  print('\n');

  // --- Exporting Data ---
  print('## Exporting Data\n');

  // Export users to JSON
  final usersToExport = Darturbation.users(count: 2);
  final jsonOutput = Darturbation.export(usersToExport, to: 'json');
  print('JSON Export (2 Users):\n$jsonOutput\n');

  // Export products to CSV
  final productsToExport = Darturbation.products(count: 2);
  final csvOutput = Darturbation.export(productsToExport, to: 'csv');
  print('CSV Export (2 Products):\n$csvOutput\n');

  // Export orders to SQL
  final usersForOrders = Darturbation.users(count: 2);
  final productsForOrders = Darturbation.products(count: 2);
  final ordersToExport = Darturbation.orders(
      count: 2, fromUsers: usersForOrders, withProducts: productsForOrders);
  final sqlOutput = Darturbation.export(ordersToExport,
      to: 'sql', tableName: 'ecommerce_orders');
  print('SQL Export (2 Orders):\n$sqlOutput\n');

  // --- Utility Methods ---
  print('## Utility Methods\n');
  print('Random Int (1-100): ${Darturbation.randomInt(1, 100)}');
  print('Random Double (0-1): ${Darturbation.randomDouble(0, 1)}');
  print('Random Choice (from [A, B, C]): ${Darturbation.randomChoice([
        'A',
        'B',
        'C'
      ])}');
  print('Random Bool (0.7 probability): ${Darturbation.randomBool(0.7)}');
  print('Generated ID: ${Darturbation.generateId()}\n');
}
