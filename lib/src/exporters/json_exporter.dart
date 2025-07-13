part of '../../darturbation.dart';

class JsonExporter implements Exporter<Map<String, dynamic>> {
  @override
  String export(List<Map<String, dynamic>> data, {bool pretty = true}) {
    if (pretty) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    }
    return jsonEncode(data);
  }
}
