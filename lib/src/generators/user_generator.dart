part of '../../darturbation.dart';

/// Generates realistic [User] data.
///
/// The [UserGenerator] creates individual user instances and streams of users,
/// ensuring that they have diverse but realistic profiles, including names,
/// contact information, demographic data, and behavioral attributes.
class UserGenerator {
  /// Generates a single [User] object.
  ///
  /// This method creates a user with a randomly determined gender, authentic
  /// Indonesian first and last names, a generated email and phone number,
  /// and a geographically consistent address. It also assigns a behavior type
  /// and preferred categories based on predefined patterns.
  ///
  /// Returns a [User] instance with generated profile data.
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

  /// Generates a [Stream] of [User] objects.
  ///
  /// This method is suitable for generating a large number of users efficiently
  /// without holding all of them in memory simultaneously. Each user is generated
  /// and yielded as it becomes available.
  ///
  /// Parameters:
  /// - [count]: The total number of users to generate in the stream (default: 10).
  ///
  /// Returns a [Stream<User>] that yields generated users.
  Stream<User> streamGenerate({int count = 10}) async* {
    for (int i = 0; i < count; i++) {
      yield generate();
    }
  }

  /// Determines the province for a given city.
  ///
  /// This helper method looks up the provided city in the predefined Indonesian
  /// province data to return its corresponding province. If the city is not found
  /// in any known province, it defaults to 'Jawa Barat'.
  ///
  /// Parameters:
  /// - [city]: The name of the city.
  ///
  /// Returns a [String] representing the province of the given city.
  String _getProvinceForCity(String city) {
    for (final entry in IndonesianData.provinces.entries) {
      if (entry.value.contains(city)) {
        return entry.key;
      }
    }
    return 'Jawa Barat'; // Default
  }

  /// Generates a realistic birth date for a user.
  ///
  /// The birth date is generated to ensure the user's age falls within a
  /// typical range (e.g., 18 to 65 years old).
  ///
  /// Returns a [DateTime] object representing the generated birth date.
  DateTime _generateBirthDate() {
    final now = DateTime.now();
    final age = Darturbation.randomInt(18, 65);
    return DateTime(now.year - age, Darturbation.randomInt(1, 12),
        Darturbation.randomInt(1, 28));
  }

  /// Generates a realistic join date for a user.
  ///
  /// The join date is set within a reasonable past period (e.g., up to 2 years ago)
  /// from the current date.
  ///
  /// Returns a [DateTime] object representing the generated join date.
  DateTime _generateJoinDate() {
    final now = DateTime.now();
    final daysAgo = Darturbation.randomInt(1, 730); // 1-2 years ago
    return now.subtract(Duration(days: daysAgo));
  }

  /// Generates a map of user preferences based on their behavior type.
  ///
  /// This method uses the [BehavioralPatterns] to assign realistic preferences
  /// such as preferred categories, price preferences, and payment methods,
  /// aligning with the user's simulated behavior.
  ///
  /// Parameters:
  /// - [behaviorType]: The user's behavior type (e.g., 'power_user').
  ///
  /// Returns a `Map<String, dynamic>` containing the generated preferences.
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
