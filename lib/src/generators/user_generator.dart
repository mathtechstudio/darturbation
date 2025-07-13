part of '../../darturbation.dart';

class UserGenerator {
  User generate() {
    final gender = Darturbation.randomChoice(['male', 'female']);
    final firstName = gender == 'male'
        ? Darturbation.randomChoice(IndonesianData.maleNames)
        : Darturbation.randomChoice(IndonesianData.femaleNames);
    final lastName = Darturbation.randomChoice(IndonesianData.lastNames);

    final behaviorType = DarturbationCore().patterns.getUserBehaviorType();
    final city = Darturbation.randomChoice(IndonesianData.cities);
    final province = _getProvinceForCity(city);

    final userBehaviorData =
        BehavioralPatterns.getUserBehaviorData(behaviorType);
    final preferredCategory = Darturbation.randomChoice(
        userBehaviorData['preferredCategories'].cast<String>());

    final tier = Darturbation.randomChoice(UserTier.values);

    return User(
      id: Darturbation.generateId(),
      firstName: firstName,
      lastName: lastName,
      email: IndonesianData.generateEmail(firstName, lastName),
      phone: IndonesianData.generatePhoneNumber(),
      address: IndonesianData.generateAddress(),
      city: city,
      province: province,
      postalCode: IndonesianData.generatePostalCode(),
      gender: gender,
      birthDate: _generateBirthDate(),
      behaviorType: behaviorType,
      joinedDate: _generateJoinDate(),
      isActive: Darturbation.randomBool(0.85),
      preferences: _generatePreferences(behaviorType),
      preferredCategory: preferredCategory,
      tier: tier,
    );
  }

  Stream<User> streamGenerate({int count = 10}) async* {
    for (int i = 0; i < count; i++) {
      yield generate();
    }
  }

  String _getProvinceForCity(String city) {
    for (final entry in IndonesianData.provinces.entries) {
      if (entry.value.contains(city)) {
        return entry.key;
      }
    }
    return 'Jawa Barat'; // Default
  }

  DateTime _generateBirthDate() {
    final now = DateTime.now();
    final age = Darturbation.randomInt(18, 65);
    return DateTime(now.year - age, Darturbation.randomInt(1, 12),
        Darturbation.randomInt(1, 28));
  }

  DateTime _generateJoinDate() {
    final now = DateTime.now();
    final daysAgo = Darturbation.randomInt(1, 730); // 1-2 years ago
    return now.subtract(Duration(days: daysAgo));
  }

  Map<String, dynamic> _generatePreferences(String behaviorType) {
    final behavior = BehavioralPatterns.getUserBehaviorData(behaviorType);
    return {
      'preferredCategories': behavior['preferredCategories'],
      'pricePreference': behavior['pricePreference'],
      'preferredPaymentMethods': behavior['paymentMethods'],
      'newsletterSubscribed': Darturbation.randomBool(0.3),
      'pushNotifications': Darturbation.randomBool(0.6),
    };
  }
}
