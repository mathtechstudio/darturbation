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
      final lowerKey = key.toLowerCase();
      if (lowerKey.contains('email')) {
        return Darturbation._faker.internet.email();
      } else if (lowerKey.contains('first_name') ||
          lowerKey.contains('firstname')) {
        return Darturbation._faker.person.firstName();
      } else if (lowerKey.contains('last_name') ||
          lowerKey.contains('lastname') ||
          lowerKey.contains('surname')) {
        return Darturbation._faker.person.lastName();
      } else if (lowerKey.contains('name') && !lowerKey.contains('_name')) {
        return Darturbation._faker.person.name();
      } else if (lowerKey.contains('username') ||
          lowerKey.contains('user_name')) {
        return '${Darturbation._faker.person.firstName().toLowerCase()}${Darturbation.randomInt(100, 999)}';
      } else if (lowerKey.contains('address')) {
        return Darturbation._faker.address.streetAddress();
      } else if (lowerKey.contains('phone') || lowerKey.contains('mobile')) {
        return IndonesianData.generatePhoneNumber();
      } else if (lowerKey.contains('city')) {
        return Darturbation.randomChoice(IndonesianData.cities);
      } else if (lowerKey.contains('country')) {
        return 'Indonesia';
      } else if (lowerKey.contains('company') ||
          lowerKey.contains('organization')) {
        return Darturbation._faker.company.name();
      } else if (lowerKey.contains('title') || lowerKey.contains('position')) {
        return Darturbation._faker.job.title();
      } else if (lowerKey.contains('description') || lowerKey.contains('bio')) {
        return Darturbation._faker.lorem
            .sentences(Darturbation.randomInt(1, 3))
            .join(' ');
      } else if (lowerKey.contains('url') || lowerKey.contains('website')) {
        return Darturbation._faker.internet.httpsUrl();
      } else if (lowerKey.contains('color')) {
        return Darturbation.randomChoice([
          'red',
          'blue',
          'green',
          'yellow',
          'purple',
          'orange',
          'pink',
          'brown',
          'black',
          'white'
        ]);
      } else if (lowerKey.contains('gender')) {
        return Darturbation.randomChoice(['male', 'female']);
      } else if (lowerKey.contains('status')) {
        return Darturbation.randomChoice(['active', 'inactive', 'pending']);
      } else if (lowerKey.contains('currency') ||
          lowerKey.contains('price') ||
          lowerKey.contains('amount')) {
        return 'IDR';
      } else {
        return Darturbation._faker.lorem.word();
      }
    } else if (type == int) {
      final lowerKey = key.toLowerCase();
      if (lowerKey.contains('age')) {
        return Darturbation.randomInt(18, 65);
      } else if (lowerKey.contains('year')) {
        return Darturbation.randomInt(1990, DateTime.now().year);
      } else if (lowerKey.contains('month')) {
        return Darturbation.randomInt(1, 12);
      } else if (lowerKey.contains('day')) {
        return Darturbation.randomInt(1, 28);
      } else if (lowerKey.contains('quantity') || lowerKey.contains('count')) {
        return Darturbation.randomInt(1, 100);
      } else if (lowerKey.contains('score') || lowerKey.contains('rating')) {
        return Darturbation.randomInt(1, 5);
      } else if (lowerKey.contains('percentage') ||
          lowerKey.contains('percent')) {
        return Darturbation.randomInt(0, 100);
      } else {
        return Darturbation.randomInt(1, 1000);
      }
    } else if (type == double) {
      final lowerKey = key.toLowerCase();
      if (lowerKey.contains('price') ||
          lowerKey.contains('amount') ||
          lowerKey.contains('cost')) {
        return Darturbation.randomDouble(
            10000, 5000000); // Indonesian Rupiah range
      } else if (lowerKey.contains('rating') || lowerKey.contains('score')) {
        return Darturbation.randomDouble(1.0, 5.0);
      } else if (lowerKey.contains('percentage') ||
          lowerKey.contains('percent')) {
        return Darturbation.randomDouble(0.0, 100.0);
      } else if (lowerKey.contains('weight')) {
        return Darturbation.randomDouble(0.1, 50.0);
      } else if (lowerKey.contains('height')) {
        return Darturbation.randomDouble(150.0, 200.0);
      } else {
        return Darturbation.randomDouble(0.0, 1000.0);
      }
    } else if (type == bool) {
      final lowerKey = key.toLowerCase();
      if (lowerKey.contains('active') || lowerKey.contains('enabled')) {
        return Darturbation.randomBool(0.8); // 80% chance of being active
      } else if (lowerKey.contains('verified') ||
          lowerKey.contains('confirmed')) {
        return Darturbation.randomBool(0.7); // 70% chance of being verified
      } else if (lowerKey.contains('premium') || lowerKey.contains('paid')) {
        return Darturbation.randomBool(0.3); // 30% chance of being premium
      } else {
        return Darturbation.randomBool(0.5);
      }
    } else if (type == DateTime) {
      final lowerKey = key.toLowerCase();
      if (lowerKey.contains('birth') || lowerKey.contains('dob')) {
        final now = DateTime.now();
        final age = Darturbation.randomInt(18, 65);
        return DateTime(now.year - age, Darturbation.randomInt(1, 12),
            Darturbation.randomInt(1, 28));
      } else if (lowerKey.contains('created') ||
          lowerKey.contains('joined') ||
          lowerKey.contains('registered')) {
        return DateTime.now().subtract(Duration(
            days: Darturbation.randomInt(1, 730))); // Up to 2 years ago
      } else if (lowerKey.contains('updated') ||
          lowerKey.contains('modified') ||
          lowerKey.contains('last')) {
        return DateTime.now().subtract(
            Duration(days: Darturbation.randomInt(0, 30))); // Up to 30 days ago
      } else {
        return DateTime.now()
            .subtract(Duration(days: Darturbation.randomInt(0, 365)));
      }
    } else if (type == List) {
      return [];
    } else if (type == Map) {
      return {};
    } else {
      return null;
    }
  }
}
