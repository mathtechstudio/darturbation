import 'package:darturbation/darturbation.dart';

void main() {
  print('🚀 Darturbation v2.0.0 - Advanced Features Demo\n');

  // ===== ENHANCED SCHEMA GENERATION =====
  print('1. 📊 Enhanced Schema Generation:');
  final improvedData = Darturbation.fromSchema(
    schema: {
      'firstName': String, // → Smart name generation
      'lastName': String, // → Smart name generation
      'emailAddress': String, // → Valid email format
      'phoneNumber': String, // → Indonesian phone format
      'userAge': int, // → Age between 18-65
      'salary': double, // → Realistic salary in IDR
      'isActive': bool, // → 80% chance true
      'createdAt': DateTime, // → Up to 2 years ago
    },
    count: 3,
  );

  for (var item in improvedData) {
    print(
        '  ${item['firstName']} ${item['lastName']} - ${item['emailAddress']}');
    print(
        '  Age: ${item['userAge']}, Salary: Rp${item['salary']}, Active: ${item['isActive']}');
    print('  Phone: ${item['phoneNumber']}, Joined: ${item['createdAt']}\n');
  }

  // ===== TIME SERIES DATA =====
  print('2. 📈 Time Series Data Generation:');
  final salesData = Darturbation.timeSeries(
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 1, 7),
    interval: Duration(days: 1),
    baseValue: 1000.0,
    trend: 0.1, // 10% upward trend
    seasonality: 0.2, // 20% seasonal variation
    noise: 0.1, // 10% random noise
  );

  print('  Weekly Sales Data:');
  for (var point in salesData) {
    final date = DateTime.parse(point['timestamp']);
    print('  ${date.day}/${date.month}: Rp${point['value']}');
  }
  print('');

  // ===== FLUTTER UTILITIES =====
  print('3. 📱 Flutter-Specific Mock Data:');

  // ListView data
  final userProfiles = Darturbation.listView(
    itemCount: 3,
    itemType: 'user_profile',
  );
  print('  User Profiles for ListView:');
  for (var user in userProfiles) {
    print('  - ${user['firstName']} ${user['lastName']} (${user['bio']})');
  }
  print('');

  // Card data
  final productCards = Darturbation.cards(
    cardCount: 3,
    cardType: 'product',
  );
  print('  Product Cards:');
  for (var product in productCards) {
    print(
        '  - ${product['name']}: Rp${product['price']} (⭐${product['rating']})');
  }
  print('');

  // Form data
  final registrationForm = Darturbation.form(
    formType: 'registration',
    includeValidation: true,
  );
  print('  Registration Form: ${registrationForm['title']}');
  final fields = registrationForm['fields'] as List;
  for (var field in fields) {
    print(
        '  - ${field['label']} (${field['type']}) ${field['required'] ? '*required' : ''}');
  }
  print('');

  // ===== API MOCKING =====
  print('4. 🌐 API Response Mocking:');

  // REST API response
  final apiResponse = Darturbation.apiResponse(
    endpoint: '/api/users',
    method: 'GET',
    dataSchema: {
      'id': String,
      'firstName': String,
      'lastName': String,
      'email': String,
    },
    itemCount: 2,
  );
  print(
      '  REST API Response (${apiResponse['status']} ${apiResponse['statusText']}):');
  final apiData = apiResponse['data'] as List;
  for (var user in apiData) {
    print('  - ${user['firstName']} ${user['lastName']} (${user['email']})');
  }
  print('');

  // WebSocket message
  final wsMessage = Darturbation.websocketMessage(
    type: 'chat_message',
    dataSchema: {
      'userId': String,
      'username': String,
      'message': String,
    },
  );
  print('  WebSocket Message (${wsMessage['type']}):');
  final messageData = wsMessage['data'] as Map<String, dynamic>;
  print('  ${messageData['username']}: "${messageData['message']}"');
  print(
      '  Channel: ${wsMessage['channel']}, Time: ${wsMessage['timestamp']}\n');

  // ===== ADVANCED ANALYTICS =====
  print('5. 🧠 Advanced Analytics Data:');

  // Hierarchical data
  final orgChart = Darturbation.hierarchical(
    schema: {
      'name': String,
      'title': String,
      'department': String,
    },
    maxDepth: 3,
    totalNodes: 8,
  );
  print('  Organizational Chart:');
  for (var employee in orgChart) {
    final indent = '  ' * (employee['depth'] + 1);
    print('$indent- ${employee['name']} (${employee['title']})');
  }
  print('');

  // Graph data
  final socialNetwork = Darturbation.graph(
    nodeCount: 5,
    nodeSchema: {
      'name': String,
      'interests': String,
    },
    connectionProbability: 0.4,
  );
  final nodes = socialNetwork['nodes'] as List;
  final edges = socialNetwork['edges'] as List;
  print('  Social Network:');
  print('  Nodes: ${nodes.length}, Connections: ${edges.length}');
  for (var node in nodes) {
    print('  - ${node['name']} (${node['interests']})');
  }
  print('');

  // Correlated series
  final businessMetrics = Darturbation.correlatedSeries(
    seriesNames: ['marketing_spend', 'sales_revenue'],
    correlationMatrix: [
      [1.0, 0.8], // marketing correlations
      [0.8, 1.0], // sales correlations
    ],
    count: 5,
    means: [50000, 100000],
    standardDeviations: [10000, 20000],
  );
  print('  Correlated Business Metrics:');
  for (int i = 0; i < 5; i++) {
    print(
        '  Day ${i + 1}: Marketing Rp${businessMetrics['marketing_spend']![i]}, '
        'Sales Rp${businessMetrics['sales_revenue']![i]}');
  }
  print('');

  // Data with anomalies
  final userData = Darturbation.withAnomalies(
    schema: {
      'age': int,
      'income': double,
      'email': String,
    },
    count: 10,
    anomalyRate: 0.3, // 30% anomalies for demo
    anomalyTypes: ['extreme_values', 'missing_data'],
  );
  print('  User Data with Anomalies:');
  for (var item in userData) {
    final data = item['data'] as Map<String, dynamic>;
    final isAnomaly = item['isAnomaly'] as bool;
    final anomalyType = item['anomalyType'];

    print(
        '  - Age: ${data['age']}, Income: ${data['income']}, Email: ${data['email']}');
    if (isAnomaly) {
      print('    ⚠️  ANOMALY: $anomalyType');
    }
  }

  print(
      '\n✨ All examples completed! Darturbation v2.0.0 is ready for production use.');
  print(
      '🎯 Perfect for Flutter developers, API testing, and advanced analytics!');
}
