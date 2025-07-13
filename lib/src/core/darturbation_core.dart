part of '../../darturbation.dart';

/// Core class for managing context, relationships, and patterns
class DarturbationCore {
  final ContextManager context = ContextManager();
  final RelationshipManager relationships = RelationshipManager();
  final PatternEngine patterns = PatternEngine();

  DarturbationCore._internal();

  static final DarturbationCore _instance = DarturbationCore._internal();

  factory DarturbationCore() {
    return _instance;
  }

  void reset() {
    context.reset();
    relationships.reset();
    // patterns.reset(); // Patterns are static, no need to reset
  }
}
