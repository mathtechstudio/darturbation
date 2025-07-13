part of '../../darturbation.dart';

enum UserTier {
  power,
  regular,
  casual,
  inactive,
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String province;
  final String postalCode;
  final String gender;
  final DateTime birthDate;
  final String behaviorType;
  final DateTime joinedDate;
  final bool isActive;
  final Map<String, dynamic> preferences;
  final String preferredCategory;
  final UserTier tier;

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
