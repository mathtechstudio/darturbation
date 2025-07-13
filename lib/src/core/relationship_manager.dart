// src/core/relationship_manager.dart
part of '../../darturbation.dart';

/// Manages relationships between generated data
class RelationshipManager {
  final Map<String, List<Map<String, dynamic>>> _generatedData = {};
  final Map<String, Map<String, dynamic>> _relationships = {};

  void storeData(String type, List<Map<String, dynamic>> data) {
    _generatedData[type] = data;
  }

  List<Map<String, dynamic>>? getData(String type) {
    return _generatedData[type];
  }

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

  Map<String, dynamic>? getRelationship(String parentType, String childType) {
    final relationshipKey = '${parentType}_$childType';
    return _relationships[relationshipKey];
  }

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

  void reset() {
    _generatedData.clear();
    _relationships.clear();
  }
}
