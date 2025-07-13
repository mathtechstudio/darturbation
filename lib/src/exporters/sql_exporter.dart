part of '../../darturbation.dart';

class SqlExporter implements Exporter<Map<String, dynamic>> {
  final String tableName;

  SqlExporter({this.tableName = 'data'});

  @override
  String export(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return '';

    final buffer = StringBuffer();
    final columns = data.first.keys.join(', ');

    for (final item in data) {
      final values = item.values.map((e) {
        if (e is String) {
          return "'${e.replaceAll("'", "''")}'";
        } else if (e is DateTime) {
          return "'${e.toIso8601String()}'";
        } else {
          return e.toString();
        }
      }).join(', ');
      buffer.writeln('INSERT INTO $tableName ($columns) VALUES ($values);');
    }

    return buffer.toString();
  }
}
