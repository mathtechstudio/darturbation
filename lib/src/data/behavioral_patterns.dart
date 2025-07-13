// src/data/behavioral_patterns.dart
part of '../../darturbation.dart';

class BehavioralPatterns {
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

  static const Map<String, List<int>> peakHours = {
    'weekday': [12, 13, 17, 18, 19, 20, 21],
    'weekend': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
    'payday': [17, 18, 19, 20, 21, 22, 23],
    'lunch': [11, 12, 13, 14],
    'evening': [17, 18, 19, 20, 21]
  };

  static const Map<String, double> categoryPopularity = {
    'fashion': 0.25,
    'electronics': 0.20,
    'food': 0.15,
    'home': 0.12,
    'health': 0.10,
    'books': 0.08,
    'sports': 0.10
  };

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

  static Map<String, dynamic> getUserBehaviorData(String behaviorType) {
    return userBehaviors[behaviorType] ?? userBehaviors['casual_user']!;
  }

  static double getSeasonalMultiplier(String category, String season) {
    return seasonalPatterns[season]?[category] ?? 1.0;
  }

  static List<int> getPeakHours(String period) {
    return peakHours[period] ?? peakHours['weekday']!;
  }

  static double getCategoryPopularity(String category) {
    return categoryPopularity[category] ?? 0.05;
  }

  static double getPriceRange(String category, String pricePreference) {
    return priceRanges[pricePreference]?[category] ?? 100000;
  }
}
