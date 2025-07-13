part of '../../darturbation.dart';

/// Exports a list of data as a CSV (Comma Separated Values) string.
///
/// This exporter takes a list of maps, where each map represents a row
/// and its keys represent the column headers. It automatically generates
/// the header row from the keys of the first data item and then converts
/// each subsequent data item into a CSV row.
///
/// Example:
/// ```dart
/// List<Map<String, dynamic>> userData = [
///   {'id': 1, 'name': 'Alice', 'age': 30},
///   {'id': 2, 'name': 'Bob', 'age': 24},
/// ];
/// String csvOutput = CsvExporter().export(userData);
/// print(csvOutput);
/// // Expected output:
/// // id,name,age
/// // 1,Alice,30
/// // 2,Bob,24
/// ```
class CsvExporter implements Exporter<Map<String, dynamic>> {
  /// Exports the given list of data to a CSV formatted string.
  ///
  /// The first row of the CSV will be the headers, derived from the keys
  /// of the first map in the [data] list. Subsequent rows will contain
  /// the values from each map, in the same order as the headers.
  ///
  /// Parameters:
  /// - [data]: A [List] of `Map<String, dynamic>` where each map represents
  ///   a row of data. All maps are expected to have the same keys for consistent columns.
  ///
  /// Returns a [String] containing the CSV formatted data.
  /// Returns an empty string if the [data] list is empty.
  @override
  String export(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return '';

    final buffer = StringBuffer();
    // Header: Use keys from the first map as column headers
    buffer.writeln(data.first.keys.join(','));

    // Rows: Iterate through each map and write its values as a CSV row
    for (final item in data) {
      // Convert all values to string and join with commas
      buffer.writeln(item.values.map((e) => e.toString()).join(','));
    }

    return buffer.toString();
  }
}
