part of '../../darturbation.dart';

/// Manages and tracks relationships between different types of generated data.
///
/// The [RelationshipManager] is crucial for ensuring that mock data is not
/// just random, but also logically interconnected. It stores generated data
/// and defines how different data entities (e.g., Users, Products, Orders)
/// relate to each other, allowing for the generation of consistent and
/// realistic datasets.
class RelationshipManager {
  /// Stores generated data, categorized by type (e.g., 'users', 'products').
  ///
  /// The keys are data type identifiers (String), and values are lists of
  /// generated data items, each represented as a `Map<String, dynamic>`.
  final Map<String, List<Map<String, dynamic>>> _generatedData = {};

  /// Stores definitions of relationships between different data types.
  ///
  /// The keys are composite strings (e.g., 'user_order'), and values are maps
  /// defining the parent type, child type, and the keys used for linking them.
  final Map<String, Map<String, dynamic>> _relationships = {};

  /// Stores a list of generated data for a specific type.
  ///
  /// This method is used by generators to register the data they produce,
  /// making it available for other generators or for relationship management.
  ///
  /// Parameters:
  /// - [type]: A [String] identifier for the type of data (e.g., 'users', 'products').
  /// - [data]: A [List<Map<String, dynamic>>] containing the generated data items.
  ///
  /// Example:
  /// ```dart
  /// // Assuming `users` is a List<User>
  /// DarturbationCore().relationships.storeData('users', users.map((u) => u.toJson()).toList());
  /// ```
  void storeData(String type, List<Map<String, dynamic>> data) {
    _generatedData[type] = data;
  }

  /// Retrieves a list of generated data for a specific type.
  ///
  /// This allows other parts of the system to access previously generated data
  /// for creating relationships or for further processing.
  ///
  /// Parameters:
  /// - [type]: A [String] identifier for the type of data to retrieve.
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the stored data, or `null`
  /// if no data is found for the given type.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>>? storedUsers = DarturbationCore().relationships.getData('users');
  /// if (storedUsers != null) {
  ///   print('Found ${storedUsers.length} users.');
  /// }
  /// ```
  List<Map<String, dynamic>>? getData(String type) {
    return _generatedData[type];
  }

  /// Defines a new relationship between a parent data type and a child data type.
  ///
  /// This method establishes how two different data entities are linked,
  /// specifying which keys in their respective data maps represent the connection.
  ///
  /// Parameters:
  /// - [parentType]: The [String] identifier for the parent data type (e.g., 'users').
  /// - [childType]: The [String] identifier for the child data type (e.g., 'orders').
  /// - [parentKey]: The key in the parent's data map that identifies the parent (e.g., 'id').
  /// - [childKey]: The key in the child's data map that links to the parent (e.g., 'userId').
  ///
  /// Example:
  /// ```dart
  /// DarturbationCore().relationships.addRelationship(
  ///   'users', 'orders', 'id', 'userId');
  /// ```
  void addRelationship(
      String parentType, String childType, String parentKey, String childKey) {
    final relationshipKey = '${parentType}_$childType';
    _relationships[relationshipKey] = {
      'parentType': parentType,
      'childType': childType,
      'parentKey': parentKey,
      'childKey': childKey,
    };
  }

  /// Retrieves the definition of a relationship between two data types.
  ///
  /// Parameters:
  /// - [parentType]: The [String] identifier for the parent data type.
  /// - [childType]: The [String] identifier for the child data type.
  ///
  /// Returns a `Map<String, dynamic>` defining the relationship, or `null`
  /// if no such relationship has been defined.
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic>? userOrderRel = DarturbationCore().relationships.getRelationship('users', 'orders');
  /// if (userOrderRel != null) {
  ///   print('User-Order relationship found.');
  /// }
  /// ```
  Map<String, dynamic>? getRelationship(String parentType, String childType) {
    final relationshipKey = '${parentType}_$childType';
    return _relationships[relationshipKey];
  }

  /// Retrieves data from a child type that is related to a specific parent ID.
  ///
  /// This method uses a predefined relationship to filter and return child data
  /// that is linked to a given parent entity.
  ///
  /// Parameters:
  /// - [parentType]: The [String] identifier for the parent data type.
  /// - [childType]: The [String] identifier for the child data type.
  /// - [parentId]: The ID of the parent entity to find related children for.
  ///
  /// Returns a [List<Map<String, dynamic>>] containing the related child data.
  /// Returns an empty list if no relationship is defined, no child data exists,
  /// or no related items are found.
  ///
  /// Example:
  /// ```dart
  /// // Assuming a user with ID 'user123' exists and orders are related by 'userId'
  /// List<Map<String, dynamic>> userOrders = DarturbationCore().relationships.getRelatedData(
  ///   'users', 'orders', 'user123');
  /// print('Orders for user123: ${userOrders.length}');
  /// ```
  List<Map<String, dynamic>> getRelatedData(
      String parentType, String childType, String parentId) {
    final relationship = getRelationship(parentType, childType);
    if (relationship == null) return [];

    final childData = getData(childType);
    if (childData == null) return [];

    return childData
        .where((item) => item[relationship['childKey']] == parentId)
        .toList();
  }

  /// Resets all stored generated data and relationship definitions.
  ///
  /// This clears the internal state of the [RelationshipManager],
  /// effectively removing all knowledge of previously generated data
  /// and their interconnections.
  void reset() {
    _generatedData.clear();
    _relationships.clear();
  }
}
