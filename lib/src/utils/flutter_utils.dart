part of '../../darturbation.dart';

/// Flutter-specific utilities for mock data generation.
class FlutterUtils {
  /// Generates mock data for ListView and GridView widgets.
  static List<Map<String, dynamic>> listViewData({
    int itemCount = 20,
    Map<String, Type> itemSchema = const {
      'id': String,
      'title': String,
      'subtitle': String,
      'trailing': String,
    },
    bool includeMetadata = false,
  }) {
    final List<Map<String, dynamic>> items = [];

    for (int i = 0; i < itemCount; i++) {
      final item = Darturbation._genericGenerator.generate(itemSchema);
      item['index'] = i;

      if (itemSchema.containsKey('imageUrl')) {
        item['imageUrl'] = 'https://picsum.photos/200/200?random=$i';
      }

      if (itemSchema.containsKey('avatarUrl')) {
        item['avatarUrl'] = 'https://i.pravatar.cc/150?img=$i';
      }

      items.add(item);
    }

    return items;
  }

  /// Generates mock data for card-based layouts.
  static List<Map<String, dynamic>> cardData({
    int cardCount = 10,
    String cardType = 'generic',
    bool includeActions = true,
  }) {
    final List<Map<String, dynamic>> cards = [];

    for (int i = 0; i < cardCount; i++) {
      Map<String, dynamic> card = {'id': Darturbation.generateId()};

      switch (cardType.toLowerCase()) {
        case 'product':
          // Generate realistic product using proper logic
          final categories = IndonesianData.productCategories.keys.toList();
          final category = Darturbation.randomChoice(categories);
          final subcategories = IndonesianData.productCategories[category]!;
          final subcategory = Darturbation.randomChoice(subcategories);

          // Get appropriate brands for this category
          final categoryBrands = IndonesianData.brandsByCategory[category] ??
              IndonesianData.productBrands;
          final brand = Darturbation.randomChoice(categoryBrands);

          // Generate realistic product name
          final productName =
              _generateRealisticProductName(brand, subcategory, category);

          card.addAll({
            'name': productName,
            'brand': brand,
            'price': Darturbation.randomDouble(10000, 1000000),
            'currency': 'IDR',
            'rating': Darturbation.randomDouble(1.0, 5.0),
            'reviewCount': Darturbation.randomInt(0, 1000),
            'imageUrl': 'https://picsum.photos/300/200?random=$i',
            'category': category,
            'subcategory': subcategory,
            'inStock': Darturbation.randomBool(0.8),
            'discount': Darturbation.randomBool(0.3)
                ? Darturbation.randomInt(5, 50)
                : 0,
          });
          break;

        case 'user':
          card.addAll({
            'name': Darturbation._faker.person.name(),
            'username': Darturbation._faker.internet.userName(),
            'bio': Darturbation._faker.lorem.sentence(),
            'avatarUrl': 'https://i.pravatar.cc/150?img=$i',
            'followerCount': Darturbation.randomInt(0, 10000),
            'followingCount': Darturbation.randomInt(0, 1000),
            'postCount': Darturbation.randomInt(0, 500),
            'isVerified': Darturbation.randomBool(0.1),
            'isFollowing': Darturbation.randomBool(0.3),
          });
          break;

        default:
          card.addAll({
            'title': Darturbation._faker.lorem
                .words(Darturbation.randomInt(2, 5))
                .join(' '),
            'description': Darturbation._faker.lorem.sentence(),
            'imageUrl': 'https://picsum.photos/300/200?random=$i',
            'value': Darturbation.randomDouble(0, 1000),
            'status':
                Darturbation.randomChoice(['active', 'inactive', 'pending']),
          });
      }

      cards.add(card);
    }

    return cards;
  }

  /// Generates mock form data for Flutter form widgets.
  static Map<String, dynamic> formData({
    String formType = 'generic',
    bool includeValidation = true,
    bool includeInitialValues = false,
  }) {
    final Map<String, dynamic> form = {
      'id': Darturbation.generateId(),
      'title': _getFormTitle(formType),
      'fields': <Map<String, dynamic>>[],
    };

    final List<Map<String, dynamic>> fields = _getFormFields(formType);

    for (var field in fields) {
      if (includeInitialValues) {
        field['initialValue'] =
            _generateFieldValue(field['type'], field['key']);
      }

      if (includeValidation) {
        field['validation'] = _getFieldValidation(field['type'], field['key']);
      }

      form['fields'].add(field);
    }

    return form;
  }

  /// Generates mock navigation data for Flutter routing.
  static Map<String, dynamic> navigationData({
    int routeCount = 10,
    bool includeParameters = false,
    bool includeHistory = true,
  }) {
    final List<Map<String, dynamic>> routes = [];
    final List<String> routeNames = [
      'home',
      'profile',
      'settings',
      'products',
      'cart',
      'checkout',
      'orders',
      'search',
      'categories',
      'favorites',
      'notifications',
      'help',
      'about',
      'contact',
      'privacy',
      'terms',
      'login',
      'register'
    ];

    for (int i = 0; i < routeCount && i < routeNames.length; i++) {
      final routeName = routeNames[i];
      final route = {
        'name': routeName,
        'path': '/$routeName',
        'title': routeName
            .replaceAll('_', ' ')
            .split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' '),
        'icon': _getRouteIcon(routeName),
        'requiresAuth': Darturbation.randomBool(0.6),
        'isBottomNavigation': i < 5,
      };

      if (includeParameters) {
        route['parameters'] = _getRouteParameters(routeName);
      }

      routes.add(route);
    }

    final result = {
      'routes': routes,
      'currentRoute': Darturbation.randomChoice(routes),
    };

    if (includeHistory) {
      final historyLength = Darturbation.randomInt(3, 10);
      result['history'] = List.generate(
          historyLength, (i) => Darturbation.randomChoice(routes));
    }

    return result;
  }

  /// Generates Flutter theme data.
  static Map<String, dynamic> themeData({
    String themeName = 'default',
    bool isDark = false,
  }) {
    final colors = {
      'primary': _generateHexColor(),
      'primaryVariant': _generateHexColor(),
      'secondary': _generateHexColor(),
      'secondaryVariant': _generateHexColor(),
      'surface': isDark ? '#121212' : '#FFFFFF',
      'background': isDark ? '#000000' : '#FAFAFA',
      'error': '#F44336',
    };

    return {
      'name': themeName,
      'isDark': isDark,
      'colors': colors,
      'typography': {
        'headline1': {'fontSize': 96, 'fontWeight': 300},
        'headline2': {'fontSize': 60, 'fontWeight': 300},
        'body1': {'fontSize': 16, 'fontWeight': 400},
        'body2': {'fontSize': 14, 'fontWeight': 400},
      },
    };
  }

  // Helper methods
  static String _getFormTitle(String formType) {
    switch (formType.toLowerCase()) {
      case 'registration':
        return 'Create Account';
      case 'login':
        return 'Sign In';
      case 'profile':
        return 'Edit Profile';
      case 'contact':
        return 'Contact Us';
      default:
        return 'Form';
    }
  }

  static List<Map<String, dynamic>> _getFormFields(String formType) {
    switch (formType.toLowerCase()) {
      case 'registration':
        return [
          {
            'key': 'firstName',
            'type': 'text',
            'label': 'First Name',
            'required': true
          },
          {
            'key': 'lastName',
            'type': 'text',
            'label': 'Last Name',
            'required': true
          },
          {'key': 'email', 'type': 'email', 'label': 'Email', 'required': true},
          {
            'key': 'password',
            'type': 'password',
            'label': 'Password',
            'required': true
          },
        ];
      case 'login':
        return [
          {'key': 'email', 'type': 'email', 'label': 'Email', 'required': true},
          {
            'key': 'password',
            'type': 'password',
            'label': 'Password',
            'required': true
          },
        ];
      default:
        return [
          {'key': 'name', 'type': 'text', 'label': 'Name', 'required': true},
          {'key': 'email', 'type': 'email', 'label': 'Email', 'required': true},
        ];
    }
  }

  static dynamic _generateFieldValue(String type, String key) {
    switch (type) {
      case 'text':
        return Darturbation._faker.person.name();
      case 'email':
        return Darturbation._faker.internet.email();
      case 'password':
        return 'password123';
      default:
        return Darturbation._faker.lorem.word();
    }
  }

  static Map<String, dynamic> _getFieldValidation(String type, String key) {
    switch (type) {
      case 'email':
        return {
          'pattern': r'^[^@]+@[^@]+\.[^@]+$',
          'message': 'Please enter a valid email address'
        };
      case 'password':
        return {
          'minLength': 8,
          'message': 'Password must be at least 8 characters'
        };
      default:
        return {'required': true, 'message': 'This field is required'};
    }
  }

  static String _getRouteIcon(String routeName) {
    final icons = {
      'home': 'home',
      'profile': 'person',
      'settings': 'settings',
      'products': 'shopping_bag',
      'cart': 'shopping_cart',
    };
    return icons[routeName] ?? 'circle';
  }

  static Map<String, dynamic> _getRouteParameters(String routeName) {
    switch (routeName) {
      case 'products':
        return {'category': 'electronics', 'sort': 'price_asc'};
      case 'profile':
        return {'userId': Darturbation.generateId()};
      default:
        return {};
    }
  }

  static String _generateHexColor() {
    return '#${Darturbation.randomInt(0, 16777215).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  /// Generate realistic product names for Flutter card data
  static String _generateRealisticProductName(
      String brand, String subcategory, String category) {
    switch (category) {
      case 'electronics':
        final models = ['Pro', 'Max', 'Plus', 'Air', 'Ultra', 'Mini', 'Lite'];
        final numbers = ['12', '13', '14', '15', 'X', 'S', 'SE'];

        switch (subcategory) {
          case 'smartphone':
            return '$brand ${Darturbation.randomChoice([
                  'Galaxy',
                  'iPhone',
                  'Redmi',
                  'Note',
                  'Find'
                ])} ${Darturbation.randomChoice(numbers)}';
          case 'laptop':
            return '$brand ${Darturbation.randomChoice([
                  'ThinkPad',
                  'MacBook',
                  'VivoBook',
                  'IdeaPad',
                  'Pavilion'
                ])} ${Darturbation.randomChoice(models)}';
          case 'tv':
            return '$brand Smart TV ${Darturbation.randomInt(32, 75)}" 4K';
          default:
            return '$brand $subcategory ${Darturbation.randomChoice(models)}';
        }
      case 'fashion':
        final colors = ['Hitam', 'Putih', 'Biru', 'Merah', 'Abu-abu', 'Navy'];

        switch (subcategory) {
          case 'kaos':
            return '$brand Kaos ${Darturbation.randomChoice(colors)} ${Darturbation.randomChoice([
                  'Premium',
                  'Basic',
                  'Slim Fit'
                ])}';
          case 'kemeja':
            return '$brand Kemeja ${Darturbation.randomChoice(colors)} ${Darturbation.randomChoice([
                  'Formal',
                  'Casual',
                  'Slim Fit'
                ])}';
          case 'sepatu':
            return '$brand Sepatu ${Darturbation.randomChoice([
                  'Sneakers',
                  'Formal',
                  'Casual',
                  'Running'
                ])}';
          default:
            return '$brand $subcategory ${Darturbation.randomChoice(colors)}';
        }
      case 'food':
        final flavors = ['Original', 'Pedas', 'Ayam Bawang', 'Soto', 'Rendang'];
        final variants = ['100gr', '200gr', '500ml', '1L', '250ml'];

        switch (subcategory) {
          case 'makanan instan':
            return '$brand Mie Instan ${Darturbation.randomChoice(flavors)}';
          case 'minuman':
            return '$brand ${Darturbation.randomChoice([
                  'Teh',
                  'Air Mineral',
                  'Jus'
                ])} ${Darturbation.randomChoice(variants)}';
          default:
            return '$brand $subcategory ${Darturbation.randomChoice(variants)}';
        }
      default:
        return '$brand $subcategory';
    }
  }
}
