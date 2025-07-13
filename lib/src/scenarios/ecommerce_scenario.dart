part of '../../darturbation.dart';

class EcommerceScenario {
  String _region = 'indonesia';
  String _seasonality = 'normal';

  EcommerceScenario() {
    DarturbationCore().context.setRegion(_region);
  }

  // Non-streaming generation methods (for backward compatibility)
  List<User> _users = [];
  List<Product> _products = [];
  List<Order> _orders = [];
  final List<Review> _reviews = [];

  EcommerceScenario users(int count, {String? region}) {
    if (region != null) {
      _region = region;
      DarturbationCore().context.setRegion(region);
    }

    _users = List.generate(count, (_) => Darturbation.user());
    DarturbationCore()
        .relationships
        .storeData('users', _users.map((u) => u.toJson()).toList());

    return this;
  }

  EcommerceScenario products(int count, {List<String>? categories}) {
    _products = List.generate(count, (_) => Darturbation.product());
    DarturbationCore()
        .relationships
        .storeData('products', _products.map((p) => p.toJson()).toList());

    return this;
  }

  EcommerceScenario orders({String? seasonality}) {
    if (seasonality != null) {
      _seasonality = seasonality;
    }

    _orders = List.generate(
        _users.length, // Generate one order per user for simplicity
        (index) =>
            Darturbation.order(user: _users[index], withProducts: _products));
    DarturbationCore()
        .relationships
        .storeData('orders', _orders.map((o) => o.toJson()).toList());

    return this;
  }

  EcommerceScenario reviews() {
    final reviewGenerator = ReviewGenerator();
    for (final order in _orders) {
      if (order.items.isNotEmpty) {
        final product = Darturbation.randomChoice(order.items);
        _reviews.add(reviewGenerator.generate(
            user: order.user, product: product, order: order));
      }
    }
    DarturbationCore()
        .relationships
        .storeData('reviews', _reviews.map((r) => r.toJson()).toList());

    return this;
  }

  Map<String, dynamic> generate() {
    return {
      'users': _users.map((u) => u.toJson()).toList(),
      'products': _products.map((p) => p.toJson()).toList(),
      'orders': _orders.map((o) => o.toJson()).toList(),
      'reviews': _reviews.map((r) => r.toJson()).toList(),
      'metadata': {
        'generatedAt': DateTime.now().toIso8601String(),
        'region': _region,
        'seasonality': _seasonality,
        'counts': {
          'users': _users.length,
          'products': _products.length,
          'orders': _orders.length,
          'reviews': _reviews.length,
        }
      }
    };
  }

  // Streaming generation methods
  Stream<Map<String, dynamic>> generateStream({
    int userCount = 10,
    int productCount = 10,
    int orderCount = 10,
    int reviewCount = 10,
  }) async* {
    final List<User> users = [];
    final List<Product> products = [];
    final List<Order> orders = [];

    await for (final user in Darturbation.streamUsers(count: userCount)) {
      users.add(user);
      yield {'type': 'user', 'data': user.toJson()};
    }

    await for (final product
        in Darturbation.streamProducts(count: productCount)) {
      products.add(product);
      yield {'type': 'product', 'data': product.toJson()};
    }

    // Generate orders based on collected users and products
    await for (final order in Darturbation.streamOrders(
        users: users, products: products, count: orderCount)) {
      orders.add(order);
      yield {'type': 'order', 'data': order.toJson()};
    }

    // Generate reviews based on collected users, products, and orders
    await for (final review in Darturbation.streamReviews(
        users: users, products: products, orders: orders, count: reviewCount)) {
      yield {'type': 'review', 'data': review.toJson()};
    }
  }
}
