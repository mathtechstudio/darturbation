part of '../../darturbation.dart';

/// Defines the different tiers or levels of user engagement.
///
/// This enum is used to categorize users based on their activity and purchasing
/// behavior, which can influence data generation patterns.
enum UserTier {
  /// Represents highly active and frequent users.
  power,

  /// Represents regularly active users with consistent engagement.
  regular,

  /// Represents users with occasional or light activity.
  casual,

  /// Represents users with very low or no recent activity.
  inactive,
}

/// Represents a user profile with various personal and behavioral attributes.
///
/// This model captures comprehensive information about a user, including their
/// unique identifier, personal details, contact information, demographic data,
/// behavioral type, preferences, and activity status.
class User {
  /// A unique identifier for the user.
  final String id;

  /// The first name of the user.
  final String firstName;

  /// The last name of the user.
  final String lastName;

  /// The email address of the user.
  final String email;

  /// The phone number of the user.
  final String phone;

  /// The street address of the user.
  final String address;

  /// The city where the user resides.
  final String city;

  /// The province where the user resides.
  final String province;

  /// The postal code of the user's address.
  final String postalCode;

  /// The gender of the user (e.g., 'male', 'female').
  final String gender;

  /// The birth date of the user.
  final DateTime birthDate;

  /// The behavioral type of the user (e.g., 'power_user', 'casual_user').
  final String behaviorType;

  /// The date when the user joined the platform or system.
  final DateTime joinedDate;

  /// A boolean indicating whether the user account is currently active.
  final bool isActive;

  /// A map for any additional, unstructured preferences of the user.
  final Map<String, dynamic> preferences;

  /// The user's preferred product category, influencing their purchasing patterns.
  final String preferredCategory;

  /// The [UserTier] representing the user's engagement level.
  final UserTier tier;

  /// Creates a [User] instance.
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.gender,
    required this.birthDate,
    required this.behaviorType,
    required this.joinedDate,
    required this.isActive,
    required this.preferences,
    required this.preferredCategory,
    required this.tier,
  });

  /// Converts this [User] instance into a JSON-compatible `Map<String, dynamic>`.
  ///
  /// This method is useful for serialization, storage, or API responses.
  /// It converts [DateTime] objects to ISO 8601 strings and the [UserTier]
  /// enum to its string representation.
  ///
  /// Returns a `Map<String, dynamic>` representing the user's data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'province': province,
      'postalCode': postalCode,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'behaviorType': behaviorType,
      'joinedDate': joinedDate.toIso8601String(),
      'isActive': isActive,
      'preferences': preferences,
      'preferredCategory': preferredCategory,
      'tier': tier.toString().split('.').last,
    };
  }
}