part of '../../darturbation.dart';

/// A versatile generator for creating data based on a provided schema.
///
/// This class allows you to define the structure of your desired data
/// using a `Map<String, Type>` and it will generate corresponding values.
/// It intelligently attempts to generate realistic data for common field names
/// like 'email', 'name', 'address', and 'phone'.
class GenericGenerator {
  /// Generates a single row of data conforming to the given [schema].
  ///
  /// For each key-value pair in the [schema], it calls [_generateValue]
  /// to produce a value of the specified [Type].
  ///
  /// Parameters:
  /// - [schema]: A map where keys are field names (String) and values are
  ///   the desired data types (Type, e.g., `String`, `int`, `double`, `bool`, `DateTime`).
  ///
  /// Returns a `Map<String, dynamic>` representing a single generated data row.
  ///
  /// Example:
  /// ```dart
  /// final customSchema = {
  ///   'user_id': int,
  ///   'user_name': String,
  ///   'user_email': String,
  ///   'is_active': bool,
  ///   'last_login': DateTime,
  /// };
  /// final generatedRow = GenericGenerator().generate(customSchema);
  /// print(generatedRow);
  /// ```
  Map<String, dynamic> generate(Map<String, Type> schema) {
    final Map<String, dynamic> row = {};
    schema.forEach((key, type) {
      row[key] = _generateValue(type, key);
    });
    return row;
  }

  /// Generates a single value based on the specified [type] and [key].
  ///
  /// This internal method is responsible for producing data for each field
  /// in the schema. It uses `faker` for more realistic string data
  /// (like emails, names, addresses, phone numbers) and `Darturbation`'s
  /// utility methods for other types.
  ///
  /// Parameters:
  /// - [type]: The desired data type for the value.
  /// - [key]: The field name, used to infer the type of data to generate
  ///   (e.g., if 'email' is in the key, it generates an email address).
  ///
  /// Returns a `dynamic` value that matches the requested [type].
  dynamic _generateValue(Type type, String key) {
    if (type == String) {
      if (key.toLowerCase().contains('email')) {
        return Darturbation._faker.internet.email();
      } else if (key.toLowerCase().contains('name')) {
        return Darturbation._faker.person.name();
      } else if (key.toLowerCase().contains('address')) {
        return Darturbation._faker.address.streetAddress();
      } else if (key.toLowerCase().contains('phone')) {
        return Darturbation._faker.phoneNumber.us();
      } else {
        return Darturbation._faker.lorem.word();
      }
    } else if (type == int) {
      return Darturbation.randomInt(0, 100);
    } else if (type == double) {
      return Darturbation.randomDouble(0, 100);
    } else if (type == bool) {
      return Darturbation.randomBool();
    } else if (type == DateTime) {
      return DateTime.now()
          .subtract(Duration(days: Darturbation.randomInt(0, 365)));
    } else {
      return null;
    }
  }
}
