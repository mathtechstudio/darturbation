part of '../../darturbation.dart';

/// Exports a list of data as SQL INSERT statements.
///
/// This exporter converts a list of maps (representing rows) into SQL INSERT
/// statements, making it easy to import generated data into a relational database.
/// It handles basic data type conversions and escapes string values to prevent
/// SQL injection issues.
///
/// Example:
/// ```dart
/// List<Map<String, dynamic>> userData = [
///   {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
///   {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'},
/// ];
/// String sqlOutput = SqlExporter(tableName: 'users').export(userData);
/// print(sqlOutput);
/// // Expected output:
/// // INSERT INTO users (id, name, email) VALUES (1, 'Alice', 'alice@example.com');
/// // INSERT INTO users (id, name, email) VALUES (2, 'Bob', 'bob@example.com');
/// ```
class SqlExporter implements Exporter<Map<String, dynamic>> {
  /// The name of the SQL table into which data will be inserted.
  /// Defaults to 'data'.
  final String tableName;

  /// Creates a [SqlExporter] instance.
  ///
  /// Parameters:
  /// - [tableName]: The name of the table for the INSERT statements.
  SqlExporter({this.tableName = 'data'});

  /// Exports the given list of data to a string containing SQL INSERT statements.
  ///
  /// The column names for the INSERT statements are derived from the keys
  /// of the first map in the [data] list. Values are automatically formatted
  /// (e.g., strings are quoted, DateTime objects are converted to ISO 8601).
  ///
  /// Parameters:
  /// - [data]: A [List] of `Map<String, dynamic>` where each map represents
  ///   a row of data. All maps are expected to have the same keys for consistent columns.
  ///
  /// Returns a [String] containing the SQL INSERT statements.
  /// Returns an empty string if the [data] list is empty.
  @override
  String export(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return '';

    final buffer = StringBuffer();
    // Get column names from the keys of the first data item
    final columns = data.first.keys.join(', ');

    for (final item in data) {
      // Format values for SQL: quote strings, convert DateTime, etc.
      final values = item.values.map((e) {
        if (e is String) {
          // Escape single quotes within strings for SQL
          return "'${e.replaceAll("'", "''")}'";
        } else if (e is DateTime) {
          // Convert DateTime to ISO 8601 string for SQL
          return "'${e.toIso8601String()}'";
        } else {
          // Convert other types directly to string
          return e.toString();
        }
      }).join(', ');
      buffer.writeln('INSERT INTO $tableName ($columns) VALUES ($values);');
    }

    return buffer.toString();
  }
}
