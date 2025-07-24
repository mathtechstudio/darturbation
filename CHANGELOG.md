# Changelog

## 2.0.0

### 🚀 Major Enhancements

## Advanced Data Generation Methods**

- Added `timeSeries()` method for generating realistic time-series data with trends, seasonality, and noise
- Introduced `hierarchical()` method for creating nested data structures with parent-child relationships
- Implemented `graph()` method for generating node-edge graph data structures
- Added `correlatedSeries()` method for creating mathematically correlated datasets
- Introduced `withAnomalies()` method for generating data with realistic outliers and anomalies

## Flutter-Specific Utilities**

- New `FlutterUtils` class with specialized methods for Flutter development:
  - `listView()` - Mock data for ListView and GridView widgets
  - `cards()` - Data structures optimized for Card widgets
  - `form()` - Comprehensive form data with validation rules
  - `navigation()` - Mock navigation routes and histories
  - `theme()` - Flutter theme data generation

## API Response Mocking

- New `ApiMocker` class for testing HTTP requests:
  - `restResponse()` - Generate realistic REST API responses
  - `graphqlResponse()` - Create GraphQL-compliant responses
  - `websocketMessage()` - Mock WebSocket message payloads
  - `errorResponse()` - Generate realistic error responses with proper status codes

## Enhanced Schema Generation**

- Dramatically improved field name recognition for context-aware generation
- Added support for specialized field types (firstName, lastName, phoneNumber, etc.)
- Implemented context-aware boolean generation with realistic probabilities
- Enhanced date generation with context-specific logic (birthDate, createdAt, updatedAt)
- Improved numeric value generation based on field names (age, price, rating, etc.)

### 🔧 Improvements

- **Fixed Output Issues**: Resolved problems where random choice and generic generation produced inconsistent or incorrect data formats
- **Better Type Safety**: Enhanced type handling throughout the library
- **Expanded Test Coverage**: Added comprehensive test suite covering all new features
- **Performance Optimizations**: Improved generation speed for large datasets
- **Documentation**: Updated with extensive examples and usage patterns

### 📱 Flutter Integration

- Added convenience methods directly in main `Darturbation` class:
  - `Darturbation.listView()` - Quick ListView data generation
  - `Darturbation.cards()` - Card widget data generation
  - `Darturbation.form()` - Form data with validation
  - `Darturbation.navigation()` - Navigation mock data
  - `Darturbation.theme()` - Theme configuration data

### 🌐 API Testing Support

- Added convenience methods for API testing:
  - `Darturbation.apiResponse()` - REST API responses
  - `Darturbation.graphqlResponse()` - GraphQL responses
  - `Darturbation.websocketMessage()` - WebSocket messages
  - `Darturbation.errorResponse()` - Error responses

### 🧪 Advanced Analytics Support

- Time-series data generation with configurable trends and seasonality
- Correlated data series for testing analytics algorithms
- Hierarchical data structures for organizational charts and category trees
- Graph data generation for social networks and dependency graphs
- Anomaly injection for testing data validation and anomaly detection systems

### 💫 Developer Experience

- All new methods include comprehensive documentation with examples
- Improved IntelliSense support with detailed parameter descriptions
- Consistent API design following Dart conventions
- Enhanced error messages and validation

---

## 1.0.0

- Initial release of Darturbation.
- Implemented core data generation for users, products, orders, and reviews.
- Added support for Indonesian-first data generation (names, addresses, phone numbers).
- Introduced context-aware generation and behavioral pattern simulation.
- Implemented schema-based data generation.
- Added streaming capabilities for large dataset generation.
- Provided data export functionalities (JSON, CSV, SQL).
- Included comprehensive examples and tests.
- Add extensive documentation and usage examples
