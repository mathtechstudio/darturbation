part of '../../darturbation.dart';

class CsvExporter implements Exporter<Map<String, dynamic>> {
  @override
  String export(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return '';

    final buffer = StringBuffer();
    // Header
    buffer.writeln(data.first.keys.join(','));

    // Rows
    for (final item in data) {
      buffer.writeln(item.values.map((e) => e.toString()).join(','));
    }

    return buffer.toString();
  }
}
