import 'package:darturbation/darturbation.dart';
import 'package:test/test.dart';

void main() {
  group('Darturbation Core Functionality', () {
    test('User generation returns a single User object', () {
      final user = Darturbation.user();

      expect(user.id, isNotEmpty);
      expect(user.firstName, isNotEmpty);
      expect(user.email, contains('@'));
    });

    test('Users generation returns a list of User objects', () {
      final users = Darturbation.users(count: 5);
      expect(users, hasLength(5));
    });

    test('Product generation returns a single Product object', () {
      final product = Darturbation.product();
      expect(product, isA<Product>());
      expect(product.id, isNotEmpty);
      expect(product.name, isNotEmpty);
      expect(product.price, greaterThan(0));
    });

    test('Products generation returns a list of Product objects', () {
      final products = Darturbation.products(count: 5);
      expect(products, hasLength(5));
    });

    test('Order generation returns a single Order object', () {
      final user = Darturbation.user();
      final products = Darturbation.products(count: 3);
      final order = Darturbation.order(user: user, withProducts: products);
      expect(order, isA<Order>());
      expect(order.id, isNotEmpty);
      expect(order.user.id, user.id);
      expect(order.items, hasLength(greaterThan(0)));
      expect(order.totalAmount, greaterThan(0));
    });

    test('Orders generation returns a list of Order objects', () {
      final users = Darturbation.users(count: 2);
      final products = Darturbation.products(count: 5);
      final orders = Darturbation.orders(
          count: 3, fromUsers: users, withProducts: products);
      expect(orders, hasLength(3));
    });

    test('fromSchema generates data based on schema', () {
      final customSchema = {
        'id': int,
        'name': String,
        'price': double,
        'is_active': bool,
        'created_at': DateTime,
      };
      final generatedData =
          Darturbation.fromSchema(schema: customSchema, count: 2);
      expect(generatedData, isA<List<Map<String, dynamic>>>());
      expect(generatedData, hasLength(2));
      expect(generatedData.first.keys,
          containsAll(['id', 'name', 'price', 'is_active', 'created_at']));
      expect(generatedData.first['id'], isA<int>());
      expect(generatedData.first['name'], isA<String>());
      expect(generatedData.first['price'], isA<double>());
      expect(generatedData.first['is_active'], isA<bool>());
      expect(generatedData.first['created_at'], isA<DateTime>());
    });

    test('randomInt generates within range', () {
      final rand = Darturbation.randomInt(10, 20);
      expect(rand, greaterThanOrEqualTo(10));
      expect(rand, lessThanOrEqualTo(20));
    });

    test('randomDouble generates within range', () {
      final rand = Darturbation.randomDouble(10.0, 20.0);
      expect(rand, greaterThanOrEqualTo(10.0));
      expect(rand, lessThanOrEqualTo(20.0));
    });

    test('randomChoice selects from list', () {
      final list = ['a', 'b', 'c'];
      final choice = Darturbation.randomChoice(list);
      expect(list, contains(choice));
    });

    test('randomBool generates boolean', () {
      final boolValue = Darturbation.randomBool();
      expect(boolValue, anyOf(isTrue, isFalse));
    });

    test('generateId generates a non-empty string', () {
      final id = Darturbation.generateId();
      expect(id, isNotEmpty);
    });
  });

  group('Darturbation Export Functionality', () {
    final users = Darturbation.users(count: 2);
    final products = Darturbation.products(count: 2);
    final orders =
        Darturbation.orders(count: 2, fromUsers: users, withProducts: products);

    test('Export to JSON', () {
      final jsonOutput = Darturbation.export(users, to: 'json');
      expect(jsonOutput, isA<String>());
      expect(jsonOutput, contains('firstName'));
      expect(jsonOutput, contains('lastName'));
    });

    test('Export to CSV', () {
      final csvOutput = Darturbation.export(products, to: 'csv');
      expect(csvOutput, isA<String>());
      expect(
          csvOutput,
          contains(
              'name,category,subcategory,description,price')); // Check header
      expect(
          csvOutput.split('\n').length, greaterThan(1)); // Check for data rows
    });

    test('Export to SQL', () {
      final sqlOutput =
          Darturbation.export(orders, to: 'sql', tableName: 'test_orders');
      expect(sqlOutput, isA<String>());
      expect(sqlOutput, contains('INSERT INTO test_orders'));
      expect(sqlOutput, contains('totalAmount'));
    });
  });

  group('Darturbation Streaming Functionality', () {
    test('streamUsers generates a stream of User objects', () async {
      final userStream = Darturbation.streamUsers(count: 3);
      final users = await userStream.toList();
      expect(users, hasLength(3));
    });

    test('streamProducts generates a stream of Product objects', () async {
      final productStream = Darturbation.streamProducts(count: 3);
      final products = await productStream.toList();
      expect(products, hasLength(3));
    });

    test('streamOrders generates a stream of Order objects', () async {
      final users = await Darturbation.streamUsers(count: 5).toList();
      final products = await Darturbation.streamProducts(count: 5).toList();
      final orderStream =
          Darturbation.streamOrders(users: users, products: products, count: 3);
      final orders = await orderStream.toList();
      expect(orders, hasLength(3));
    });

    test('streamReviews generates a stream of Review objects', () async {
      final users = await Darturbation.streamUsers(count: 5).toList();
      final products = await Darturbation.streamProducts(count: 5).toList();
      final orders = await Darturbation.streamOrders(
              users: users, products: products, count: 5)
          .toList();
      final reviewStream = Darturbation.streamReviews(
          users: users, products: products, orders: orders, count: 3);
      final reviews = await reviewStream.toList();
      expect(reviews, hasLength(3));
    });
  });

  group('EcommerceScenario Functionality', () {
    test('Non-streaming scenario generates all data types', () {
      final scenario = Darturbation.scenario('ecommerce')
          .users(2)
          .products(2)
          .orders()
          .reviews();
      final data = scenario.generate();

      expect(data['users'], isA<List<dynamic>>());
      expect(data['users'], hasLength(2));
      expect(data['products'], isA<List<dynamic>>());
      expect(data['products'], hasLength(2));
      expect(data['orders'], isA<List<dynamic>>());
      expect(data['orders'], hasLength(2));
      expect(data['reviews'], isA<List<dynamic>>());
      expect(
          data['reviews'],
          hasLength(greaterThanOrEqualTo(
              0))); // Reviews might not always be generated if order.items is empty
      expect(data['metadata'], isA<Map<String, dynamic>>());
    });

    test('Streaming scenario generates streams for all data types', () async {
      final scenario = Darturbation.scenario('ecommerce');
      final Stream<Map<String, dynamic>> streams = scenario.generateStream(
        userCount: 2,
        productCount: 2,
        orderCount: 2,
        reviewCount: 2,
      );

      final List<Map<String, dynamic>> streamedData = await streams.toList();

      // Check that the correct number of each type of data is present
      expect(
          streamedData.where((item) => item['type'] == 'user'), hasLength(2));
      expect(streamedData.where((item) => item['type'] == 'product'),
          hasLength(2));
      expect(
          streamedData.where((item) => item['type'] == 'order'), hasLength(2));
      expect(
          streamedData.where((item) => item['type'] == 'review'), hasLength(2));

      // Optionally, check the type of the data within the map
      expect(
          streamedData
              .where((item) => item['type'] == 'user')
              .every((item) => item['data'] is Map<String, dynamic>),
          isTrue);
      expect(
          streamedData
              .where((item) => item['type'] == 'product')
              .every((item) => item['data'] is Map<String, dynamic>),
          isTrue);
      expect(
          streamedData
              .where((item) => item['type'] == 'order')
              .every((item) => item['data'] is Map<String, dynamic>),
          isTrue);
      expect(
          streamedData
              .where((item) => item['type'] == 'review')
              .every((item) => item['data'] is Map<String, dynamic>),
          isTrue);
    });
  });
}
