part of '../../darturbation.dart';

class GenericGenerator {
  Map<String, dynamic> generate(Map<String, Type> schema) {
    final Map<String, dynamic> row = {};
    schema.forEach((key, type) {
      row[key] = _generateValue(type, key);
    });
    return row;
  }

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
