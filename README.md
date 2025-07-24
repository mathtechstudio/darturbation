# 💦 Darturbation 💦: Advanced Mock Data Generator for Dart & Flutter

[![Dart CI](https://github.com/mathtechstudio/darturbation/actions/workflows/ci.yml/badge.svg)](https://github.com/mathtechstudio/darturbation/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/version-2.0.0-blue)](https://pub.dev/packages/darturbation)
[![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue)](https://pub.dev/packages/darturbation)

**Darturbation** is the most advanced mock data generator for Dart and Flutter applications, designed specifically for developers who need realistic, context-aware, and behaviorally consistent test data. Unlike traditional faker libraries, Darturbation generates data that maintains logical relationships and follows real-world patterns.

## 🚀 What's New in v2.0.0

### 🎯 **Advanced Data Generation**

- **Time Series Data** - Generate realistic data with trends, seasonality, and noise
- **Hierarchical Structures** - Create nested data with parent-child relationships
- **Graph Data** - Generate network data with nodes and edges
- **Correlated Datasets** - Create mathematically correlated data series
- **Anomaly Injection** - Add realistic outliers for testing data validation

### 📱 **Flutter-Specific Features**

- **ListView/GridView Data** - Optimized mock data for Flutter list widgets
- **Card Widget Data** - Pre-structured data for Material Design cards
- **Form Generation** - Complete form data with validation rules
- **Navigation Mock** - Route and navigation history simulation
- **Theme Data** - Generate Flutter theme configurations

### 🌐 **API Testing Tools**

- **REST API Mocking** - Generate realistic API responses with proper headers
- **GraphQL Support** - Create GraphQL-compliant responses
- **WebSocket Messages** - Mock real-time message payloads
- **Error Responses** - Generate proper HTTP error responses with status codes

## 🏆 Core Value Proposition

### 1. **Indonesian-First Approach**

Generate authentic Indonesian data that feels real:

- **Authentic Names**: Budi Santoso, Siti Rahayu, Agus Setiawan
- **Real Addresses**: Complete with Indonesian cities, provinces, and RT/RW
- **Local Phone Numbers**: Properly formatted Indonesian mobile numbers
- **Cultural Context**: Data that reflects Indonesian cultural patterns

### 2. **Context-Aware Intelligence**

Smart data generation that maintains logical relationships:

- **Related Fields**: Email addresses match names, cities match provinces
- **Behavioral Consistency**: User demographics influence purchasing patterns
- **Temporal Logic**: Order dates align with user registration, reviews follow purchases
- **Geographic Correlation**: Addresses, cities, and postal codes are geographically consistent

### 3. **Behavioral Pattern Simulation**

Realistic patterns that mirror real-world behavior:

- **Seasonal Trends**: Ramadan boost, Christmas sales, payday effects
- **User Archetypes**: Power users, casual shoppers, inactive accounts
- **Natural Distributions**: Pareto principle for sales, realistic rating distributions
- **Time-Based Patterns**: Weekend activity, business hours, seasonal variations

## 📦 Installation

Add Darturbation to your `pubspec.yaml`:

```yaml
dependencies:
  darturbation: ^2.0.0
```

Then run:

```bash
dart pub get
```

## 🚀 Quick Start

```dart
import 'package:darturbation/darturbation.dart';

void main() {
  // Generate a single user
  final user = Darturbation.user();
  print('${user.firstName} ${user.lastName} - ${user.email}');
  
  // Generate multiple products
  final products = Darturbation.products(count: 5);
  products.forEach((p) => print('${p.name}: Rp${p.price}'));
  
  // Generate with custom schema
  final customData = Darturbation.fromSchema(
    schema: {
      'firstName': String,
      'lastName': String,
      'age': int,
      'isActive': bool,
      'salary': double,
      'joinDate': DateTime,
    },
    count: 10,
  );
}
```

## 🎯 Advanced Features

### 📊 **Time Series Data Generation**

Perfect for testing analytics dashboards and time-based visualizations:

```dart
// Generate sales data with trend and seasonality
final salesData = Darturbation.timeSeries(
  startDate: DateTime(2023, 1, 1),
  endDate: DateTime(2023, 12, 31),
  interval: Duration(days: 1),
  baseValue: 1000.0,
  trend: 0.1,           // 10% upward trend
  seasonality: 0.3,     // 30% seasonal variation
  noise: 0.1,           // 10% random noise
);

// Use in your charts
salesData.forEach((point) {
  print('${point['date']}: ${point['value']}');
});
```

### 🌳 **Hierarchical Data Structures**

Generate organizational charts, category trees, or any nested data:

```dart
// Create company org chart
final orgChart = Darturbation.hierarchical(
  schema: {
    'name': String,
    'title': String,
    'department': String,
    'salary': double,
  },
  maxDepth: 4,
  totalNodes: 100,
  childrenPerNode: [2, 5], // 2-5 direct reports per manager
);

// Access hierarchical relationships
orgChart.forEach((employee) {
  print('${employee['name']} (${employee['title']}) - Depth: ${employee['depth']}');
  print('Reports to: ${employee['parentId']}');
  print('Direct Reports: ${employee['children'].length}');
});
```

### 🕸️ **Graph Data Generation**

Create network data for social networks, dependency graphs, or relationship analysis:

```dart
// Generate social network data
final socialNetwork = Darturbation.graph(
  nodeCount: 100,
  nodeSchema: {
    'name': String,
    'age': int,
    'interests': String,
    'location': String,
  },
  connectionProbability: 0.15, // 15% chance of connection
  directed: false,
);

// Access nodes and relationships
final nodes = socialNetwork['nodes'];
final edges = socialNetwork['edges'];
final metadata = socialNetwork['metadata'];

print('Generated ${nodes.length} users with ${edges.length} connections');
print('Average connections per user: ${metadata['averageDegree']}');
```

### 📈 **Correlated Data Series**

Generate mathematically correlated datasets for testing analytics algorithms:

```dart
// Create correlated business metrics
final businessMetrics = Darturbation.correlatedSeries(
  seriesNames: ['marketing_spend', 'website_traffic', 'sales_revenue'],
  correlationMatrix: [
    [1.0, 0.8, 0.6],  // marketing_spend correlations
    [0.8, 1.0, 0.7],  // website_traffic correlations  
    [0.6, 0.7, 1.0],  // sales_revenue correlations
  ],
  count: 365, // One year of daily data
  means: [10000, 50000, 25000],
  standardDeviations: [2000, 10000, 5000],
);

// Use for testing correlation analysis
print('Marketing Spend vs Sales correlation: ${calculateCorrelation(
  businessMetrics['marketing_spend']!,
  businessMetrics['sales_revenue']!,
)}');
```

### 🚨 **Data with Anomalies**

Generate datasets with realistic outliers for testing data validation and anomaly detection:

```dart
// Create user data with anomalies
final userData = Darturbation.withAnomalies(
  schema: {
    'age': int,
    'income': double,
    'email': String,
    'lastLogin': DateTime,
  },
  count: 1000,
  anomalyRate: 0.05, // 5% anomalies
  anomalyTypes: ['extreme_values', 'missing_data', 'inconsistent_patterns'],
);

// Filter and analyze anomalies
final anomalies = userData.where((item) => item['isAnomaly'] == true).toList();
print('Found ${anomalies.length} anomalies:');
anomalies.forEach((anomaly) {
  print('Type: ${anomaly['anomalyType']}, Data: ${anomaly['data']}');
});
```

## 📱 Flutter-Specific Features

### 📋 **ListView/GridView Mock Data**

Generate data optimized for Flutter list widgets:

```dart
// Generate user profile list data
final userProfiles = Darturbation.listView(
  itemCount: 50,
  itemType: 'user_profile',
);

// Use in ListView.builder
ListView.builder(
  itemCount: userProfiles.length,
  itemBuilder: (context, index) {
    final user = userProfiles[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user['avatarUrl']),
      ),
      title: Text('${user['firstName']} ${user['lastName']}'),
      subtitle: Text(user['bio']),
      trailing: Text(user['joinedDate'].toString()),
    );
  },
);
```

### 🎴 **Card Widget Data**

Pre-structured data for Material Design cards:

```dart
// Generate product cards
final productCards = Darturbation.cards(
  cardCount: 20,
  cardType: 'product',
);

// Use in card widgets
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  itemCount: productCards.length,
  itemBuilder: (context, index) {
    final product = productCards[index];
    return Card(
      child: Column(
        children: [
          Image.network(product['imageUrl']),
          Text(product['name']),
          Text('Rp${product['price']}'),
          Row(
            children: [
              Icon(Icons.star),
              Text('${product['rating']}'),
              Text('(${product['reviewCount']} reviews)'),
            ],
          ),
        ],
      ),
    );
  },
);
```

### 📝 **Form Generation with Validation**

Complete form data with validation rules:

```dart
// Generate registration form
final registrationForm = Darturbation.form(
  formType: 'registration',
  includeValidation: true,
  includeInitialValues: true,
);

// Use form data to build forms
final formFields = registrationForm['fields'] as List;
Column(
  children: formFields.map((field) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: field['label'],
        hintText: field['initialValue']?.toString(),
      ),
      validator: (value) {
        final validation = field['validation'];
        if (validation['required'] && (value?.isEmpty ?? true)) {
          return validation['message'];
        }
        return null;
      },
    );
  }).toList(),
);
```

### 🧭 **Navigation Mock Data**

Generate navigation routes and history:

```dart
// Generate app navigation structure
final navigationData = Darturbation.navigation(
  routeCount: 15,
  includeHistory: true,
);

// Use for testing navigation
final routes = navigationData['routes'] as List;
final currentRoute = navigationData['currentRoute'];
final history = navigationData['history'] as List;

// Build navigation drawer
Drawer(
  child: ListView(
    children: routes.map((route) {
      return ListTile(
        leading: Icon(getIconData(route['icon'])),
        title: Text(route['title']),
        onTap: () => Navigator.pushNamed(context, route['path']),
      );
    }).toList(),
  ),
);
```

### 🎨 **Theme Data Generation**

Generate Flutter theme configurations:

```dart
// Generate dark theme
final darkTheme = Darturbation.theme(
  themeName: 'dark_professional',
  isDark: true,
);

// Apply to ThemeData
final themeData = ThemeData(
  brightness: darkTheme['isDark'] ? Brightness.dark : Brightness.light,
  primaryColor: Color(int.parse(darkTheme['colors']['primary'].substring(1), radix: 16)),
  scaffoldBackgroundColor: Color(int.parse(darkTheme['colors']['background'].substring(1), radix: 16)),
  // ... apply other theme properties
);
```

## 🌐 API Testing & Mocking

### 🔄 **REST API Response Mocking**

Generate realistic API responses with proper structure:

```dart
// Mock user list API response
final userListResponse = Darturbation.apiResponse(
  endpoint: '/api/users',
  method: 'GET',
  dataSchema: {
    'id': String,
    'firstName': String,
    'lastName': String,
    'email': String,
    'avatar': String,
  },
  itemCount: 20,
  statusCode: 200,
);

// Use in HTTP client testing
when(mockHttpClient.get('/api/users'))
  .thenAnswer((_) async => Response(
    jsonEncode(userListResponse),
    userListResponse['status'],
    headers: userListResponse['headers'],
  ));
```

### 📊 **GraphQL Response Mocking**

Create GraphQL-compliant responses:

```dart
// Mock GraphQL query response
final graphqlResponse = Darturbation.graphqlResponse(
  query: '''
    query GetUsers {
      users {
        id
        name
        email
        posts {
          title
          content
        }
      }
    }
  ''',
  dataSchema: {
    'users': List,
  },
  itemCount: 10,
);

// Use in GraphQL client testing
when(mockGraphQLClient.query(any))
  .thenAnswer((_) async => QueryResult(
    data: graphqlResponse['data'],
    errors: graphqlResponse['errors'],
  ));
```

### 💬 **WebSocket Message Mocking**

Generate realistic WebSocket messages:

```dart
// Mock chat message
final chatMessage = Darturbation.websocketMessage(
  type: 'chat_message',
  dataSchema: {
    'userId': String,
    'username': String,
    'message': String,
    'timestamp': DateTime,
  },
);

// Use in WebSocket testing
final mockMessages = List.generate(50, (i) => 
  Darturbation.websocketMessage(
    type: 'chat_message',
    dataSchema: {
      'userId': String,
      'message': String,
    },
  ),
);
```

### ❌ **Error Response Generation**

Generate proper HTTP error responses:

```dart
// Generate 404 error
final notFoundError = Darturbation.errorResponse(
  statusCode: 404,
  message: 'User not found',
);

// Generate validation error
final validationError = Darturbation.errorResponse(
  statusCode: 422,
);

// Use in error handling tests
when(mockHttpClient.get('/api/users/invalid-id'))
  .thenAnswer((_) async => Response(
    jsonEncode(notFoundError),
    404,
  ));
```

## 🏪 E-commerce Scenario

Generate complete e-commerce datasets with realistic relationships:

```dart
// Generate complete e-commerce scenario
final ecommerceData = Darturbation.scenario('indonesian_ecommerce')
  .users(100)
  .products(200)
  .orders()
  .reviews()
  .generate();

// Access generated data
final users = ecommerceData['users'] as List<User>;
final products = ecommerceData['products'] as List<Product>;
final orders = ecommerceData['orders'] as List<Order>;
final reviews = ecommerceData['reviews'] as List<Review>;

// Verify relationships
orders.forEach((order) {
  print('Order ${order.id} by ${order.user.firstName}');
  print('Items: ${order.items.map((item) => item.product.name).join(', ')}');
  print('Total: Rp${order.totalAmount}');
});
```

## 🌊 Streaming for Large Datasets

Handle large datasets efficiently with streaming:

```dart
// Stream 10,000 users without memory issues
final userStream = Darturbation.streamUsers(count: 10000);

await for (final user in userStream) {
  // Process one user at a time
  await saveUserToDatabase(user);
  
  // Progress tracking
  if (user.id.hashCode % 1000 == 0) {
    print('Processed ${user.id.hashCode} users...');
  }
}
```

## 📤 Data Export

Export generated data in multiple formats:

```dart
final users = Darturbation.users(count: 100);

// Export to JSON
final jsonData = Darturbation.export(users, to: 'json');
File('users.json').writeAsStringSync(jsonData);

// Export to CSV
final csvData = Darturbation.export(users, to: 'csv');
File('users.csv').writeAsStringSync(csvData);

// Export to SQL
final sqlData = Darturbation.export(
  users, 
  to: 'sql', 
  tableName: 'app_users',
);
File('users.sql').writeAsStringSync(sqlData);
```

## 🛠 Schema-Based Generation

Improved schema intelligence with context-aware field recognition:

```dart
// Smart field recognition
final userData = Darturbation.fromSchema(
  schema: {
    // Names
    'firstName': String,      // → Indonesian first names
    'lastName': String,       // → Indonesian last names
    
    // Contact Info
    'emailAddress': String,   // → Valid email format
    'phoneNumber': String,    // → Indonesian phone format
    
    // Demographics
    'userAge': int,          // → Age between 18-65
    'gender': String,        // → 'male' or 'female'
    
    // Business Data
    'salary': double,        // → Realistic salary range (IDR)
    'isActive': bool,        // → 80% chance true
    'isVerified': bool,      // → 70% chance true
    'isPremium': bool,       // → 30% chance true
    
    // Dates
    'birthDate': DateTime,   // → Age-appropriate birth date
    'createdAt': DateTime,   // → Up to 2 years ago
    'updatedAt': DateTime,   // → Recent (last 30 days)
  },
  count: 1000,
);
```

## 📖 Complete API Reference

### **Core Methods**

```dart
// Single entity generation
User user()
Product product()
Order order({required User user, required List<Product> withProducts})

// Bulk generation
List<User> users({int count = 10})
List<Product> products({int count = 10})
List<Order> orders({int count = 10, required List<User> fromUsers, required List<Product> withProducts})

// Streaming generation
Stream<User> streamUsers({int count = 10})
Stream<Product> streamProducts({int count = 10})
Stream<Order> streamOrders({required List<User> users, required List<Product> products, int count = 10})

// Schema-based generation
List<Map<String, dynamic>> fromSchema({required Map<String, Type> schema, int count = 10})

// Advanced generation
List<Map<String, dynamic>> timeSeries({required DateTime startDate, required DateTime endDate, ...})
List<Map<String, dynamic>> hierarchical({required Map<String, Type> schema, int maxDepth = 3, ...})
Map<String, dynamic> graph({int nodeCount = 50, Map<String, Type> nodeSchema, ...})
Map<String, List<double>> correlatedSeries({required List<String> seriesNames, ...})
List<Map<String, dynamic>> withAnomalies({required Map<String, Type> schema, double anomalyRate = 0.1, ...})
```

### **Flutter-Specific Methods**

```dart
// UI component data
List<Map<String, dynamic>> listView({int itemCount = 20, String itemType = 'generic'})
List<Map<String, dynamic>> cards({int cardCount = 10, String cardType = 'generic'})
Map<String, dynamic> form({String formType = 'generic', bool includeValidation = true})
Map<String, dynamic> navigation({int routeCount = 10, bool includeHistory = true})
Map<String, dynamic> theme({String themeName = 'default', bool isDark = false})
```

### **API Testing Methods**

```dart
// API response mocking
Map<String, dynamic> apiResponse({required String endpoint, String method = 'GET', ...})
Map<String, dynamic> graphqlResponse({required String query, Map<String, Type> dataSchema, ...})
Map<String, dynamic> websocketMessage({required String type, Map<String, Type> dataSchema})
Map<String, dynamic> errorResponse({int statusCode = 500, String? message})
```

### **Utility Methods**

```dart
// Random utilities
int randomInt(int min, int max)
double randomDouble(double min, double max)
T randomChoice<T>(List<T> items)
bool randomBool([double probability = 0.5])
String generateId()

// Export utilities
String export<T>(List<T> data, {required String to, String tableName = 'data'})

// Scenario utilities
EcommerceScenario scenario(String type)
```

## 🧪 Testing Examples

### Unit Testing with Mocked Data

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:darturbation/darturbation.dart';

void main() {
  group('User Service Tests', () {
    test('should process user data correctly', () {
      // Generate test users
      final testUsers = Darturbation.users(count: 10);
      
      // Test your service
      final userService = UserService();
      final result = userService.processUsers(testUsers);
      
      expect(result.length, equals(10));
      expect(result.every((user) => user.isValid), isTrue);
    });
    
    test('should handle API errors gracefully', () {
      // Generate error response
      final errorResponse = Darturbation.errorResponse(
        statusCode: 500,
        message: 'Internal server error',
      );
      
      // Test error handling
      expect(
        () => apiClient.handleResponse(errorResponse),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
```

### Widget Testing with Mock Data

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:darturbation/darturbation.dart';

void main() {
  testWidgets('User list displays correctly', (WidgetTester tester) async {
    // Generate test data
    final mockUsers = Darturbation.listView(
      itemCount: 5,
      itemType: 'user_profile',
    );
    
    // Build widget with mock data
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(users: mockUsers),
      ),
    );
    
    // Verify UI elements
    expect(find.byType(ListTile), findsNWidgets(5));
    expect(find.text(mockUsers.first['firstName']), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNWidgets(5));
  });
}
```

## 🎯 Use Cases

### **For Flutter Developers**

- **UI Testing**: Generate realistic data for ListView, GridView, and Card widgets
- **Form Testing**: Create form data with validation rules
- **Theme Testing**: Generate color schemes and typography settings
- **Navigation Testing**: Mock route structures and navigation flows

### **For Backend Developers**

- **API Testing**: Generate realistic request/response data
- **Database Testing**: Create test datasets with proper relationships
- **Performance Testing**: Generate large datasets for load testing
- **Error Handling**: Test with realistic error responses

### **For Data Scientists**

- **Algorithm Testing**: Generate correlated datasets for ML model testing
- **Time Series Analysis**: Create temporal data with trends and seasonality
- **Anomaly Detection**: Test with datasets containing realistic outliers
- **Graph Analysis**: Generate network data for social network analysis

### **For QA Engineers**

- **Test Data Management**: Generate consistent test datasets
- **Edge Case Testing**: Create data with anomalies and edge cases
- **Cross-Platform Testing**: Generate data that works across platforms
- **Automated Testing**: Integration with testing frameworks

## 🌟 Why Choose Darturbation?

### **vs Traditional Faker Libraries**

- ✅ **Context-Aware**: Data fields are logically related
- ✅ **Behavioral Patterns**: Realistic user behavior simulation
- ✅ **Indonesian Focus**: Authentic local data
- ✅ **Advanced Features**: Time series, graphs, hierarchical data
- ✅ **Flutter Integration**: Specialized Flutter utilities

### **vs Manual Test Data Creation**

- ✅ **Scale**: Generate thousands of records instantly
- ✅ **Variety**: Diverse data patterns and edge cases  
- ✅ **Consistency**: Reproducible data generation
- ✅ **Maintenance**: No manual updates needed
- ✅ **Realism**: Statistically accurate distributions

### **vs Static JSON Files**

- ✅ **Dynamic**: Fresh data every time
- ✅ **Customizable**: Adjust parameters as needed
- ✅ **Scalable**: Generate any amount of data
- ✅ **Relationships**: Maintain data relationships
- ✅ **Formats**: Export to multiple formats

## 📚 Resources

- **[API Documentation](https://pub.dev/documentation/darturbation/latest/)**
- **[GitHub Repository](https://github.com/mathtechstudio/darturbation)**
- **[Example Projects](https://github.com/mathtechstudio/darturbation/tree/main/example)**
- **[Contributing Guide](https://github.com/mathtechstudio/darturbation/blob/main/CONTRIBUTING.md)**

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- 🐛 **Bug Reports**: Help us identify and fix issues
- 💡 **Feature Requests**: Suggest new capabilities  
- 🔧 **Code Contributions**: Submit pull requests
- 📖 **Documentation**: Improve guides and examples
- 🌍 **Localization**: Add support for other regions

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<h1 align="center" </h1>

[⭐ Star on GitHub](https://github.com/mathtechstudio/darturbation)
[📦 View on pub.dev](https://pub.dev/packages/darturbation)
[🐛 Report Issues](https://github.com/mathtechstudio/darturbation/issues)

</div>
