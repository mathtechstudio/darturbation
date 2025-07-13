part of '../../darturbation.dart';

/// Exports a list of data as a JSON (JavaScript Object Notation) string.
///
/// This exporter takes a list of maps, where each map represents a JSON object.
/// It can produce either a compact JSON string or a pretty-formatted one
/// with indentation for better readability.
///
/// Example:
/// ```dart
/// List<Map<String, dynamic>> userData = [
///   {'id': 1, 'name': 'Alice', 'age': 30},
///   {'id': 2, 'name': 'Bob', 'age': 24},
/// ];
/// String jsonOutput = JsonExporter().export(userData, pretty: true);
/// print(jsonOutput);
/// // Expected output (pretty-formatted):
/// // [
/// //   {
/// //     "id": 1,
/// //     "name": "Alice",
/// //     "age": 30
/// //   },
/// //   {
/// //     "id": 2,
/// //     "name": "Bob",
/// //     "age": 24
/// //   }
/// // ]
/// ```
class JsonExporter implements Exporter<Map<String, dynamic>> {
  /// Exports the given list of data to a JSON formatted string.
  ///
  /// Parameters:
  /// - [data]: A [List] of `Map<String, dynamic>` where each map represents
  ///   a JSON object.
  /// - [pretty]: A [bool] indicating whether the output JSON should be
  ///   pretty-formatted with indentation (default: `true`).
  ///
  /// Returns a [String] containing the JSON formatted data.
  /// Returns an empty string if the [data] list is empty.
  @override
  String export(List<Map<String, dynamic>> data, {bool pretty = true}) {
    if (data.isEmpty) return '';

    if (pretty) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    }
    return jsonEncode(data);
  }
}