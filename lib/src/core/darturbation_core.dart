part of '../../darturbation.dart';

/// The central core of the Darturbation library.
///
/// This singleton class provides access to key managers for context, relationships,
/// and behavioral patterns, ensuring consistent and coordinated data generation.
/// It acts as a central hub for the internal state and logic of the Darturbation system.
class DarturbationCore {
  /// Manages the generation context and regional settings.
  ///
  /// Provides access to properties like current region, language, and custom settings
  /// that influence how data is generated.
  final ContextManager context = ContextManager();

  /// Manages relationships between generated data entities.
  ///
  /// Responsible for storing and retrieving data to maintain logical connections
  /// and consistency across different generated datasets (e.g., users, products, orders).
  final RelationshipManager relationships = RelationshipManager();

  /// Handles the application of behavioral patterns and realistic data distribution.
  ///
  /// Provides methods for generating user behavior types, realistic prices, and
  /// applying seasonal multipliers to data generation.
  final PatternEngine patterns = PatternEngine();

  /// Private constructor to enforce the singleton pattern.
  DarturbationCore._internal();

  /// The single instance of [DarturbationCore].
  static final DarturbationCore _instance = DarturbationCore._internal();

  /// Factory constructor to provide the singleton instance of [DarturbationCore].
  ///
  /// Use this to access the core functionalities of the Darturbation library.
  ///
  /// Example:
  /// ```dart
  /// DarturbationCore core = DarturbationCore();
  /// core.context.setRegion('us');
  /// ```
  factory DarturbationCore() {
    return _instance;
  }

  /// Resets the state of the context and relationship managers.
  ///
  /// This method clears all stored context settings and relationships,
  /// effectively resetting the generation environment to its default state.
  ///
  /// Note: [PatternEngine] does not need to be reset as its patterns are static.
  void reset() {
    context.reset();
    relationships.reset();
  }
}