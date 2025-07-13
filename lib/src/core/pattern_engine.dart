part of '../../darturbation.dart';

/// Manages and applies behavioral patterns and realistic data distribution logic.
///
/// The [PatternEngine] is responsible for simulating various real-world behaviors
/// and trends, such as user activity types, seasonal sales boosts, and realistic
/// pricing variations. It leverages predefined behavioral data to generate
/// more authentic and interconnected mock data.
class PatternEngine {
  /// A static instance of [Random] for generating random values within the engine.
  static final Random _random = Random();

  /// Determines a user's behavior type based on a predefined probability distribution.
  ///
  /// This method simulates different user segments (e.g., power users, casual users)
  /// by assigning a behavior type according to a set of probabilities.
  ///
  /// Returns a [String] representing the assigned user behavior type.
  /// Possible return values include 'power_user', 'regular_user', 'casual_user',
  /// and 'inactive_user'.
  String getUserBehaviorType() {
    final rand = _random.nextDouble();
    if (rand < 0.05) return 'power_user'; // 5% - High activity
    if (rand < 0.20) return 'regular_user'; // 15% - Regular activity
    if (rand < 0.60) return 'casual_user'; // 40% - Casual activity
    return 'inactive_user'; // 40% - Low activity
  }

  /// Retrieves the typical order frequency for a given user behavior type.
  ///
  /// This method uses predefined behavioral patterns to determine a realistic
  /// range for how often a user of a specific type might place orders.
  ///
  /// Parameters:
  /// - [behaviorType]: A [String] representing the user's behavior type
  ///   (e.g., 'power_user', 'regular_user').
  ///
  /// Returns an [int] representing a random order frequency within the defined
  /// range for the given behavior type. Returns 0 or 1 as a default if the
  /// behavior type is unknown or has no defined frequency.
  int getOrderFrequency(String behaviorType) {
    final frequency =
        BehavioralPatterns.userBehaviors[behaviorType]?['orderFrequency'];
    if (frequency != null) {
      return Darturbation.randomInt(frequency['min'], frequency['max']);
    }
    return Darturbation.randomInt(0, 1); // Default for unknown behavior
  }

  /// Generates a realistic price for a product based on its category and
  /// a specified price preference.
  ///
  /// This method applies a base price from [BehavioralPatterns] and introduces
  /// a random variation to simulate market fluctuations and diverse pricing.
  ///
  /// Parameters:
  /// - [category]: The product category (e.g., 'electronics', 'fashion').
  /// - [pricePreference]: The user's price preference (e.g., 'budget',
  ///   'mid_range', 'premium').
  ///
  /// Returns a [double] representing a realistic price for the product.
  double getRealisticPrice(String category, String pricePreference) {
    final basePrice =
        BehavioralPatterns.getPriceRange(category, pricePreference);
    final variation = 0.3; // 30% variation
    final multiplier = 1 + ((_random.nextDouble() - 0.5) * variation);
    return basePrice * multiplier;
  }

  /// Calculates a seasonal multiplier for sales patterns based on the given date and pattern.
  ///
  /// This method simulates seasonal trends (e.g., Ramadan, Christmas, payday boosts)
  /// that can affect sales volumes or other metrics. In a more advanced implementation,
  /// this could also consider regional settings from [ContextManager].
  ///
  /// Parameters:
  /// - [date]: The [DateTime] for which to calculate the seasonal multiplier.
  /// - [pattern]: A [String] indicating the seasonal pattern to apply
  ///   (e.g., 'ramadan_boost', 'christmas_boost', 'payday_boost').
  ///
  /// Returns a [double] representing the multiplier for the specified season.
  /// Returns 1.0 if no specific pattern is matched.
  double getSeasonalMultiplier(DateTime date, String pattern) {
    switch (pattern.toLowerCase()) {
      case 'ramadan_boost':
        return _getRamadanMultiplier(date);
      case 'christmas_boost':
        return _getChristmasMultiplier(date);
      case 'payday_boost':
        return _getPaydayMultiplier(date);
      default:
        return 1.0;
    }
  }

  /// Calculates the Ramadan-specific sales multiplier.
  ///
  /// This is a simplified implementation. A more accurate version would
  /// calculate actual Islamic calendar dates.
  ///
  /// Parameters:
  /// - [date]: The [DateTime] to check against Ramadan periods.
  ///
  /// Returns a [double] multiplier based on the month.
  double _getRamadanMultiplier(DateTime date) {
    final month = date.month;
    if (month == 4 || month == 5) return 1.5; // Ramadan season
    if (month == 6) return 2.0; // Eid shopping
    return 1.0;
  }

  /// Calculates the Christmas-specific sales multiplier.
  ///
  /// Parameters:
  /// - [date]: The [DateTime] to check against the Christmas period.
  ///
  /// Returns a [double] multiplier based on the month.
  double _getChristmasMultiplier(DateTime date) {
    if (date.month == 12) return 1.8;
    if (date.month == 1) return 0.7; // Post-holiday slump
    return 1.0;
  }

  /// Calculates the payday-specific sales multiplier.
  ///
  /// This simulates increased purchasing activity around typical payday dates.
  ///
  /// Parameters:
  /// - [date]: The [DateTime] to check for payday periods.
  ///
  /// Returns a [double] multiplier based on the day of the month.
  double _getPaydayMultiplier(DateTime date) {
    final day = date.day;
    if (day >= 25 && day <= 31) return 1.3; // End of month payday
    if (day >= 1 && day <= 5) return 1.2; // Beginning of month
    return 1.0;
  }

  /// Generates a review comment based on user behavior type and product rating.
  ///
  /// This method simulates realistic review generation, where users with
  /// certain behaviors are more likely to leave reviews, and the content
  /// varies based on the product's rating.
  ///
  /// Parameters:
  /// - [behaviorType]: The user's behavior type (e.g., 'power_user').
  /// - [productRating]: The rating given to the product (e.g., 1.0 to 5.0).
  ///
  /// Returns a [String] containing a generated review comment, or an empty
  /// string if no review is generated based on the likelihood.
  String generateReviewComment(String behaviorType, double productRating) {
    final likelihood = BehavioralPatterns.userBehaviors[behaviorType]
            ?['reviewLikelihood'] ??
        0.5;
    if (_random.nextDouble() < likelihood) {
      if (productRating >= 4.0) {
        return Darturbation.randomChoice(IndonesianData.reviewComments);
      } else if (productRating >= 2.0) {
        return 'Produk lumayan, tapi ada beberapa kekurangan.';
      } else {
        return 'Produk sangat mengecewakan, tidak sesuai harapan.';
      }
    } else {
      return ''; // No review generated
    }
  }
}