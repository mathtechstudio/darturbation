part of '../../darturbation.dart';

/// Handles behavioral patterns and realistic data distribution
class PatternEngine {
  static final Random _random = Random();

  /// Generate user behavior type based on distribution
  String getUserBehaviorType() {
    final rand = _random.nextDouble();
    if (rand < 0.05) return 'power_user'; // 5% - High activity
    if (rand < 0.20) return 'regular_user'; // 15% - Regular activity
    if (rand < 0.60) return 'casual_user'; // 40% - Casual activity
    return 'inactive_user'; // 40% - Low activity
  }

  /// Get order frequency based on user behavior
  int getOrderFrequency(String behaviorType) {
    final frequency =
        BehavioralPatterns.userBehaviors[behaviorType]?['orderFrequency'];
    if (frequency != null) {
      return Darturbation.randomInt(frequency['min'], frequency['max']);
    }
    return Darturbation.randomInt(0, 1); // Default for unknown behavior
  }

  /// Generate realistic price based on category and user price preference
  double getRealisticPrice(String category, String pricePreference) {
    final basePrice =
        BehavioralPatterns.getPriceRange(category, pricePreference);
    final variation = 0.3; // 30% variation
    final multiplier = 1 + ((_random.nextDouble() - 0.5) * variation);
    return basePrice * multiplier;
  }

  /// Generate seasonal multiplier for sales patterns
  double getSeasonalMultiplier(DateTime date, String pattern) {
    // In a real implementation, this would consider the current region from ContextManager
    // For now, it uses the existing logic.
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

  double _getRamadanMultiplier(DateTime date) {
    // Simplified - in real implementation would calculate actual Ramadan dates
    final month = date.month;
    if (month == 4 || month == 5) return 1.5; // Ramadan season
    if (month == 6) return 2.0; // Eid shopping
    return 1.0;
  }

  double _getChristmasMultiplier(DateTime date) {
    if (date.month == 12) return 1.8;
    if (date.month == 1) return 0.7; // Post-holiday slump
    return 1.0;
  }

  double _getPaydayMultiplier(DateTime date) {
    final day = date.day;
    if (day >= 25 && day <= 31) return 1.3; // End of month payday
    if (day >= 1 && day <= 5) return 1.2; // Beginning of month
    return 1.0;
  }

  /// Generate review sentiment/content based on likelihood
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
