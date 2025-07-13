part of '../../darturbation.dart';

/// A collection of static data and methods defining various behavioral patterns
/// and distributions used in Darturbation's data generation.
///
/// This class centralizes the configuration for simulating realistic user behaviors,
/// seasonal trends, and pricing models, ensuring consistency across generated data.
class BehavioralPatterns {
  /// Defines characteristics and preferences for different user behavior types.
  ///
  /// Each key represents a behavior type (e.g., 'power_user', 'regular_user'),
  /// and its value is a map containing properties like:
  /// - `orderFrequency`: Min/max range for order frequency.
  /// - `avgOrderValue`: Min/max range for average order value.
  /// - `reviewLikelihood`: Probability of leaving a review.
  /// - `preferredCategories`: List of preferred product categories.
  /// - `pricePreference`: User's preference for product pricing (e.g., 'premium', 'budget').
  /// - `paymentMethods`: List of preferred payment methods.
  /// - `activityHours`: Typical hours of online activity.
  static const Map<String, Map<String, dynamic>> userBehaviors = {
    'power_user': {
      'orderFrequency': {'min': 8, 'max': 20},
      'avgOrderValue': {'min': 200000, 'max': 1000000},
      'reviewLikelihood': 0.8,
      'preferredCategories': ['electronics', 'fashion', 'home'],
      'pricePreference': 'premium',
      'paymentMethods': ['GoPay', 'OVO', 'Credit Card', 'Transfer Bank'],
      'activityHours': [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
    },
    'regular_user': {
      'orderFrequency': {'min': 3, 'max': 8},
      'avgOrderValue': {'min': 100000, 'max': 500000},
      'reviewLikelihood': 0.6,
      'preferredCategories': ['fashion', 'books', 'food', 'health'],
      'pricePreference': 'mid_range',
      'paymentMethods': ['GoPay', 'OVO', 'DANA', 'Transfer Bank', 'COD'],
      'activityHours': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    },
    'casual_user': {
      'orderFrequency': {'min': 1, 'max': 3},
      'avgOrderValue': {'min': 50000, 'max': 200000},
      'reviewLikelihood': 0.3,
      'preferredCategories': ['food', 'books', 'health', 'sports'],
      'pricePreference': 'budget',
      'paymentMethods': ['COD', 'Transfer Bank', 'Alfamart', 'Indomaret'],
      'activityHours': [12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
    },
    'inactive_user': {
      'orderFrequency': {'min': 0, 'max': 1},
      'avgOrderValue': {'min': 30000, 'max': 100000},
      'reviewLikelihood': 0.1,
      'preferredCategories': ['food', 'books'],
      'pricePreference': 'budget',
      'paymentMethods': ['COD', 'Transfer Bank'],
      'activityHours': [14, 15, 16, 17, 18, 19, 20]
    }
  };

  /// Defines multipliers for various product categories during different seasonal events.
  ///
  /// This map helps simulate how sales or demand for certain product types
  /// might fluctuate based on real-world seasonal patterns (e.g., increased
  /// food sales during Ramadan, higher fashion sales during Eid).
  /// Keys are season names (e.g., 'ramadan', 'christmas'), and values are maps
  /// of category-specific multipliers.
  static const Map<String, Map<String, double>> seasonalPatterns = {
    'ramadan': {
      'food': 1.8,
      'books': 1.3,
      'health': 1.2,
      'electronics': 0.9,
      'fashion': 0.8,
      'home': 0.7,
      'sports': 0.6
    },
    'eid': {
      'fashion': 2.5,
      'food': 2.0,
      'electronics': 1.5,
      'home': 1.3,
      'books': 1.1,
      'health': 1.0,
      'sports': 0.8
    },
    'back_to_school': {
      'books': 2.2,
      'electronics': 1.8,
      'fashion': 1.4,
      'sports': 1.2,
      'health': 1.0,
      'food': 1.0,
      'home': 0.9
    },
    'christmas': {
      'electronics': 1.9,
      'fashion': 1.6,
      'home': 1.4,
      'books': 1.2,
      'food': 1.3,
      'health': 1.0,
      'sports': 1.1
    },
    'new_year': {
      'health': 1.8,
      'sports': 1.7,
      'books': 1.4,
      'electronics': 1.2,
      'fashion': 1.1,
      'home': 1.0,
      'food': 0.9
    }
  };

  /// Defines typical peak hours for user activity during different periods.
  ///
  /// This data can be used to simulate when users are most active online,
  /// influencing the timing of generated events like orders or reviews.
  /// Keys are period names (e.g., 'weekday', 'weekend', 'payday'), and values
  /// are lists of typical active hours (0-23).
  static const Map<String, List<int>> peakHours = {
    'weekday': [12, 13, 17, 18, 19, 20, 21],
    'weekend': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
    'payday': [17, 18, 19, 20, 21, 22, 23],
    'lunch': [11, 12, 13, 14],
    'evening': [17, 18, 19, 20, 21]
  };

  /// Defines the general popularity or market share of different product categories.
  ///
  /// This can be used to influence the distribution of generated products
  /// or the likelihood of a user interacting with a certain category.
  /// Keys are category names, and values are their popularity scores (double).
  static const Map<String, double> categoryPopularity = {
    'fashion': 0.25,
    'electronics': 0.20,
    'food': 0.15,
    'home': 0.12,
    'health': 0.10,
    'books': 0.08,
    'sports': 0.10
  };

  /// Defines typical price ranges for products within different categories
  /// and for different price preferences (budget, mid-range, premium).
  ///
  /// This data helps generate realistic product prices that align with
  /// market expectations and user spending habits.
  /// Keys are price preference levels, and values are maps of category-specific
  /// base prices.
  static const Map<String, Map<String, double>> priceRanges = {
    'budget': {
      'electronics': 200000,
      'fashion': 100000,
      'home': 150000,
      'books': 50000,
      'food': 30000,
      'health': 80000,
      'sports': 120000
    },
    'mid_range': {
      'electronics': 1000000,
      'fashion': 300000,
      'home': 500000,
      'books': 100000,
      'food': 80000,
      'health': 200000,
      'sports': 400000
    },
    'premium': {
      'electronics': 5000000,
      'fashion': 800000,
      'home': 2000000,
      'books': 200000,
      'food': 200000,
      'health': 500000,
      'sports': 1000000
    }
  };

  /// Retrieves the behavioral data for a specific user behavior type.
  ///
  /// Parameters:
  /// - [behaviorType]: The [String] identifier for the user behavior type
  ///   (e.g., 'power_user', 'casual_user').
  ///
  /// Returns a `Map<String, dynamic>` containing the detailed behavioral
  /// characteristics for the specified type. Defaults to 'casual_user' data
  /// if the provided `behaviorType` is not found.
  static Map<String, dynamic> getUserBehaviorData(String behaviorType) {
    return userBehaviors[behaviorType] ?? userBehaviors['casual_user']!;
  }

  /// Retrieves the seasonal sales multiplier for a given product category and season.
  ///
  /// Parameters:
  /// - [category]: The product category (e.g., 'food', 'electronics').
  /// - [season]: The name of the season or event (e.g., 'ramadan', 'christmas').
  ///
  /// Returns a [double] representing the sales multiplier. Defaults to 1.0
  /// if the category or season is not found in the predefined patterns.
  static double getSeasonalMultiplier(String category, String season) {
    return seasonalPatterns[season]?[category] ?? 1.0;
  }

  /// Retrieves the list of peak activity hours for a given period.
  ///
  /// Parameters:
  /// - [period]: The period for which to retrieve peak hours (e.g., 'weekday',
  ///   'weekend', 'payday').
  ///
  /// Returns a [List<int>] of hours (0-23) that are considered peak activity
  /// times. Defaults to 'weekday' peak hours if the period is not found.
  static List<int> getPeakHours(String period) {
    return peakHours[period] ?? peakHours['weekday']!;
  }

  /// Retrieves the popularity score for a given product category.
  ///
  /// Parameters:
  /// - [category]: The product category (e.g., 'fashion', 'books').
  ///
  /// Returns a [double] representing the category's popularity. Defaults to 0.05
  /// if the category is not found.
  static double getCategoryPopularity(String category) {
    return categoryPopularity[category] ?? 0.05;
  }

  /// Retrieves a base price for a product category based on a specified price preference.
  ///
  /// Parameters:
  /// - [category]: The product category (e.g., 'electronics', 'home').
  /// - [pricePreference]: The desired price preference (e.g., 'budget',
  ///   'mid_range', 'premium').
  ///
  /// Returns a [double] representing the base price. Defaults to 100000
  /// if the category or price preference is not found.
  static double getPriceRange(String category, String pricePreference) {
    return priceRanges[pricePreference]?[category] ?? 100000;
  }
}
