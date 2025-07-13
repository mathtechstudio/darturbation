part of '../../darturbation.dart';

/// An abstract base class for data exporters.
///
/// This class defines the contract for any data exporter within Darturbation.
/// Concrete implementations (e.g., [CsvExporter], [JsonExporter], [SqlExporter])
/// must provide an implementation for the [export] method.
///
/// Type parameter [T] represents the type of data items that the exporter handles.
abstract class Exporter<T> {
  /// Exports a list of data items to a specific format.
  ///
  /// Concrete implementations of this method will define how the [data]
  /// is transformed into the desired output format (e.g., CSV string, JSON string).
  ///
  /// Parameters:
  /// - [data]: A [List] of data items of type [T] to be exported.
  ///
  /// Returns a [String] representing the exported data in the specific format.
  String export(List<T> data);
}
