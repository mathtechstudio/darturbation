part of '../../darturbation.dart';

/// Manages generation context and regional settings
class ContextManager {
  String _region = 'indonesia';
  String _language = 'id';
  final Map<String, dynamic> _settings = {};

  String get region => _region;
  String get language => _language;
  Map<String, dynamic> get settings => Map.from(_settings);

  void setRegion(String region) {
    _region = region.toLowerCase();
  }

  void setLanguage(String language) {
    _language = language.toLowerCase();
  }

  void setSetting(String key, dynamic value) {
    _settings[key] = value;
  }

  T? getSetting<T>(String key) {
    return _settings[key] as T?;
  }

  void reset() {
    _region = 'indonesia';
    _language = 'id';
    _settings.clear();
  }
}
