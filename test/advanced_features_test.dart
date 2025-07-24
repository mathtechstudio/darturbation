import 'package:darturbation/darturbation.dart';
import 'package:test/test.dart';

void main() {
  group('Advanced Features Tests', () {
    test('Time series generation', () {
      final timeSeries = Darturbation.timeSeries(
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 1, 10),
        interval: Duration(days: 1),
        baseValue: 100.0,
      );

      expect(timeSeries, isA<List<Map<String, dynamic>>>());
      expect(timeSeries.length, equals(10));
      expect(timeSeries.first['timestamp'], isA<String>());
      expect(timeSeries.first['value'], isA<double>());
      expect(timeSeries.first['date'], isA<DateTime>());
    });

    test('Hierarchical data generation', () {
      final hierarchical = Darturbation.hierarchical(
        schema: {
          'name': String,
          'department': String,
        },
        maxDepth: 3,
        totalNodes: 20,
      );

      expect(hierarchical, isA<List<Map<String, dynamic>>>());
      expect(hierarchical.length, lessThanOrEqualTo(20));

      final rootNodes =
          hierarchical.where((node) => node['parentId'] == null).toList();
      expect(rootNodes, isNotEmpty);

      for (var node in hierarchical) {
        expect(node['id'], isA<String>());
        expect(node['depth'], isA<int>());
        expect(node['children'], isA<List>());
      }
    });

    test('Graph generation', () {
      final graph = Darturbation.graph(
        nodeCount: 10,
        nodeSchema: {
          'name': String,
          'value': int,
        },
        connectionProbability: 0.3,
      );

      expect(graph, isA<Map<String, dynamic>>());
      expect(graph['nodes'], isA<List>());
      expect(graph['edges'], isA<List>());
      expect(graph['metadata'], isA<Map<String, dynamic>>());

      final nodes = graph['nodes'] as List;
      final edges = graph['edges'] as List;

      expect(nodes.length, equals(10));

      for (var node in nodes) {
        expect(node['id'], isA<String>());
        expect(node['name'], isA<String>());
        expect(node['value'], isA<int>());
      }

      for (var edge in edges) {
        expect(edge['source'], isA<String>());
        expect(edge['target'], isA<String>());
        expect(edge['weight'], isA<double>());
      }
    });

    test('Correlated series generation', () {
      final correlatedData = Darturbation.correlatedSeries(
        seriesNames: ['temperature', 'sales'],
        correlationMatrix: [
          [1.0, 0.8],
          [0.8, 1.0],
        ],
        count: 50,
      );

      expect(correlatedData, isA<Map<String, List<double>>>());
      expect(correlatedData['temperature'], hasLength(50));
      expect(correlatedData['sales'], hasLength(50));

      for (var value in correlatedData['temperature']!) {
        expect(value, isA<double>());
      }
    });

    test('Data with anomalies generation', () {
      final anomalousData = Darturbation.withAnomalies(
        schema: {
          'value': double,
          'category': String,
        },
        count: 100,
        anomalyRate: 0.1,
      );

      expect(anomalousData, isA<List<Map<String, dynamic>>>());
      expect(anomalousData.length, equals(100));

      final anomalies =
          anomalousData.where((item) => item['isAnomaly'] == true).toList();
      expect(anomalies.length, greaterThanOrEqualTo(5));
      expect(anomalies.length, lessThanOrEqualTo(15));

      for (var item in anomalousData) {
        expect(item['data'], isA<Map<String, dynamic>>());
        expect(item['isAnomaly'], isA<bool>());
        expect(item['index'], isA<int>());
      }
    });
  });

  group('Flutter Utils Tests', () {
    test('ListView data generation', () {
      final listData = Darturbation.listView(
        itemCount: 20,
        itemType: 'user_profile',
      );

      expect(listData, isA<List<Map<String, dynamic>>>());
      expect(listData.length, equals(20));

      for (var item in listData) {
        expect(item['id'], isA<String>());
        expect(item['firstName'], isA<String>());
        expect(item['lastName'], isA<String>());
        expect(item['email'], isA<String>());
      }
    });

    test('Card data generation', () {
      final cards = Darturbation.cards(
        cardCount: 10,
        cardType: 'product',
      );

      expect(cards, isA<List<Map<String, dynamic>>>());
      expect(cards.length, equals(10));

      for (var card in cards) {
        expect(card['id'], isA<String>());
        expect(card['name'], isA<String>());
        expect(card['price'], isA<double>());
        expect(card['currency'], equals('IDR'));
      }
    });

    test('Form data generation', () {
      final form = Darturbation.form(
        formType: 'registration',
        includeValidation: true,
      );

      expect(form, isA<Map<String, dynamic>>());
      expect(form['id'], isA<String>());
      expect(form['title'], equals('Create Account'));
      expect(form['fields'], isA<List>());

      final fields = form['fields'] as List;
      expect(fields, isNotEmpty);

      for (var field in fields) {
        expect(field['key'], isA<String>());
        expect(field['type'], isA<String>());
        expect(field['label'], isA<String>());
        expect(field['required'], isA<bool>());
        expect(field['validation'], isA<Map<String, dynamic>>());
      }
    });

    test('Navigation data generation', () {
      final navigation = Darturbation.navigation(
        routeCount: 15,
        includeHistory: true,
      );

      expect(navigation, isA<Map<String, dynamic>>());
      expect(navigation['routes'], isA<List>());
      expect(navigation['currentRoute'], isA<Map<String, dynamic>>());
      expect(navigation['history'], isA<List>());

      final routes = navigation['routes'] as List;
      expect(routes.length, equals(15));

      for (var route in routes) {
        expect(route['name'], isA<String>());
        expect(route['path'], isA<String>());
        expect(route['title'], isA<String>());
        expect(route['icon'], isA<String>());
      }
    });

    test('Theme data generation', () {
      final theme = Darturbation.theme(
        themeName: 'dark',
        isDark: true,
      );

      expect(theme, isA<Map<String, dynamic>>());
      expect(theme['name'], equals('dark'));
      expect(theme['isDark'], equals(true));
      expect(theme['colors'], isA<Map<String, dynamic>>());
      expect(theme['typography'], isA<Map<String, dynamic>>());

      final colors = theme['colors'] as Map<String, dynamic>;
      expect(colors['primary'], isA<String>());
      expect(colors['surface'], equals('#121212'));
      expect(colors['background'], equals('#000000'));
    });
  });

  group('API Mocker Tests', () {
    test('REST API response generation', () {
      final response = Darturbation.apiResponse(
        endpoint: '/api/users',
        method: 'GET',
        itemCount: 5,
      );

      expect(response, isA<Map<String, dynamic>>());
      expect(response['status'], equals(200));
      expect(response['statusText'], equals('OK'));
      expect(response['data'], isA<List>());
      expect(response['headers'], isA<Map<String, dynamic>>());

      final data = response['data'] as List;
      expect(data.length, equals(5));
    });

    test('GraphQL response generation', () {
      final response = Darturbation.graphqlResponse(
        query: 'query GetUsers { users { id name } }',
        dataSchema: {'users': List},
        itemCount: 3,
      );

      expect(response, isA<Map<String, dynamic>>());
      expect(response['data'], isA<Map<String, dynamic>>());

      final data = response['data'] as Map<String, dynamic>;
      expect(data['users'], isA<List>());

      final users = data['users'] as List;
      expect(users.length, equals(3));
    });

    test('WebSocket message generation', () {
      final message = Darturbation.websocketMessage(
        type: 'chat_message',
        dataSchema: {
          'userId': String,
          'message': String,
        },
      );

      expect(message, isA<Map<String, dynamic>>());
      expect(message['id'], isA<String>());
      expect(message['type'], equals('chat_message'));
      expect(message['timestamp'], isA<String>());
      expect(message['data'], isA<Map<String, dynamic>>());
      expect(message['channel'], isA<String>());

      final data = message['data'] as Map<String, dynamic>;
      expect(data['userId'], isA<String>());
      expect(data['message'], isA<String>());
    });

    test('Error response generation', () {
      final error = Darturbation.errorResponse(
        statusCode: 404,
        message: 'Resource not found',
      );

      expect(error, isA<Map<String, dynamic>>());
      expect(error['status'], equals(404));
      expect(error['statusText'], equals('Not Found'));
      expect(error['error'], isA<Map<String, dynamic>>());

      final errorData = error['error'] as Map<String, dynamic>;
      expect(errorData['code'], equals(404));
      expect(errorData['message'], equals('Resource not found'));
      expect(errorData['type'], equals('client_error'));
    });
  });

  group('Enhanced Schema Generation Tests', () {
    test('Improved field name recognition', () {
      final data = Darturbation.fromSchema(
        schema: {
          'firstName': String,
          'lastName': String,
          'emailAddress': String,
          'phoneNumber': String,
          'cityName': String,
          'countryName': String,
          'userAge': int,
          'itemPrice': double,
          'isActive': bool,
          'createdDate': DateTime,
        },
        count: 1,
      );

      expect(data, hasLength(1));
      final item = data.first;

      expect(item['firstName'], isA<String>());
      expect(item['lastName'], isA<String>());
      expect(item['emailAddress'], contains('@'));
      expect(item['phoneNumber'], isA<String>());
      expect(item['cityName'], isA<String>());
      expect(item['countryName'], isA<String>());
      expect(item['userAge'], greaterThanOrEqualTo(18));
      expect(item['userAge'], lessThanOrEqualTo(65));
      expect(item['itemPrice'], greaterThanOrEqualTo(10000));
      expect(item['isActive'], isA<bool>());
      expect(item['createdDate'], isA<DateTime>());
    });

    test('Context-aware boolean generation', () {
      final data = Darturbation.fromSchema(
        schema: {
          'isActive': bool,
          'isVerified': bool,
          'isPremium': bool,
        },
        count: 100,
      );

      final activeCount = data.where((item) => item['isActive'] == true).length;
      final verifiedCount =
          data.where((item) => item['isVerified'] == true).length;
      final premiumCount =
          data.where((item) => item['isPremium'] == true).length;

      // Active should be around 80%
      expect(activeCount, greaterThan(60));
      expect(activeCount, lessThan(95));

      // Verified should be around 70%
      expect(verifiedCount, greaterThan(55));
      expect(verifiedCount, lessThan(85));

      // Premium should be around 30%
      expect(premiumCount, greaterThan(15));
      expect(premiumCount, lessThan(45));
    });

    test('Context-aware date generation', () {
      final data = Darturbation.fromSchema(
        schema: {
          'birthDate': DateTime,
          'createdAt': DateTime,
          'updatedAt': DateTime,
        },
        count: 10,
      );

      final now = DateTime.now();

      for (var item in data) {
        final birthDate = item['birthDate'] as DateTime;
        final createdAt = item['createdAt'] as DateTime;
        final updatedAt = item['updatedAt'] as DateTime;

        // Birth date should be for adult age
        expect(birthDate.year, lessThan(now.year - 17));
        expect(birthDate.year, greaterThan(now.year - 66));

        // Created date should be in the past (up to 2 years)
        expect(createdAt.isBefore(now), isTrue);

        // Updated date should be recent (up to 30 days)
        expect(updatedAt.isBefore(now), isTrue);
        expect(updatedAt.isAfter(now.subtract(Duration(days: 31))), isTrue);
      }
    });
  });
}
