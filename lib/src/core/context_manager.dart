part of '../../darturbation.dart';

/// Manages the generation context and regional settings for Darturbation.
///
/// This class allows configuring and retrieving settings that influence
/// data generation, such as the target region and language. It ensures
/// that generated data is culturally and geographically relevant.
class ContextManager {
  String _region = 'indonesia';
  String _language = 'id';
  final Map<String, dynamic> _settings = {};

  /// The currently set region for data generation (e.g., 'indonesia').
  String get region => _region;

  /// The currently set language for data generation (e.g., 'id').
  String get language => _language;

  /// A map of custom settings that can influence data generation.
  ///
  /// This provides flexibility for users to inject custom configurations
  /// that might be used by specific generators or patterns.
  Map<String, dynamic> get settings => Map.from(_settings);

  /// Sets the region for data generation.
  ///
  /// The region influences localized data generation, such as names, addresses,
  /// and cultural patterns.
  ///
  /// Parameters:
  /// - [region]: The region identifier (e.g., 'indonesia', 'us').
  void setRegion(String region) {
    _region = region.toLowerCase();
  }

  /// Sets the language for data generation.
  ///
  /// The language influences localized text generation and formatting.
  ///
  /// Parameters:
  /// - [language]: The language identifier (e.g., 'id', 'en').
  void setLanguage(String language) {
    _language = language.toLowerCase();
  }

  /// Sets a custom setting with a given key and value.
  ///
  /// This allows for flexible configuration of generation parameters.
  ///
  /// Parameters:
  /// - [key]: The key for the setting.
  /// - [value]: The value to associate with the key.
  void setSetting(String key, dynamic value) {
    _settings[key] = value;
  }

  /// Retrieves a custom setting by its key.
  ///
  /// Parameters:
  /// - [key]: The key of the setting to retrieve.
  ///
  /// Returns the value associated with the key, or `null` if the key is not found.
  T? getSetting<T>(String key) {
    return _settings[key] as T?;
  }

  /// Resets all context settings to their default values.
  ///
  /// This includes resetting the region to 'indonesia', language to 'id',
  /// and clearing all custom settings.
  void reset() {
    _region = 'indonesia';
    _language = 'id';
    _settings.clear();
  }
}