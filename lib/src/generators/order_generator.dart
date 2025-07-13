part of '../../darturbation.dart';

/// Generates realistic [Order] data.
///
/// The [OrderGenerator] is responsible for creating individual order instances
/// and streams of orders, ensuring that they reflect realistic purchasing
/// behaviors and maintain logical relationships with users and products.
class OrderGenerator {
  /// Generates a single [Order] object.
  ///
  /// This method creates an order with a dynamic number of items based on the
  /// user's behavior type. It also attempts to include products from the user's
  /// preferred category, if available.
  ///
  /// Parameters:
  /// - [user]: The [User] object for whom the order is being generated.
  /// - [withProducts]: A [List] of available [Product]s that can be included in the order.
  ///
  /// Returns an [Order] instance with generated details, including items, total price,
  /// status, payment method, and shipping information.
  ///
  /// Throws an [ArgumentError] if [withProducts] is empty.
  Order generate({
    required User user,
    required List<Product> withProducts,
  }) {
    if (withProducts.isEmpty) {
      throw ArgumentError('Product list cannot be empty.');
    }

    // Determine item count based on user behavior type, ensuring at least one item.
    final int itemCount = max(
        1, DarturbationCore().patterns.getOrderFrequency(user.behaviorType));

    final items = <Product>[];
    double totalPrice = 0;

    for (int i = 0; i < itemCount; i++) {
      Product product;
      // 75% chance to pick a product from the user's preferred category
      if (Darturbation.randomDouble(0, 1) < 0.75 &&
          user.preferredCategory.isNotEmpty) {
        final preferredProducts = withProducts
            .where((p) => p.category == user.preferredCategory)
            .toList();
        if (preferredProducts.isNotEmpty) {
          product = preferredProducts[
              Darturbation.randomInt(0, preferredProducts.length - 1)];
        } else {
          product =
              withProducts[Darturbation.randomInt(0, withProducts.length - 1)];
        }
      } else {
        product =
            withProducts[Darturbation.randomInt(0, withProducts.length - 1)];
      }
      items.add(product);
      totalPrice += product.price;
    }

    return Order(
      id: Darturbation.generateId(),
      user: user,
      status: Darturbation.randomChoice(IndonesianData.orderStatuses),
      totalAmount: totalPrice,
      shippingCost: Darturbation.randomDouble(5000, 50000),
      discountAmount: Darturbation.randomDouble(0, totalPrice * 0.1),
      paymentMethod: Darturbation.randomChoice(IndonesianData.paymentMethods),
      shippingAddress: IndonesianData.generateAddress(),
      orderDate: DateTime.now()
          .subtract(Duration(days: Darturbation.randomInt(0, 365))),
      items: items,
      metadata: {},
    );
  }

  /// Generates a [Stream] of [Order] objects.
  ///
  /// This method is suitable for generating a large number of orders efficiently
  /// without holding all of them in memory simultaneously. Each order is generated
  /// and yielded as it becomes available.
  ///
  /// Parameters:
  /// - [users]: A [List] of [User] objects from which orders will be generated.
  /// - [products]: A [List] of [Product] objects that can be included in the orders.
  /// - [count]: The total number of orders to generate in the stream (default: 10).
  ///
  /// Returns a [Stream<Order>] that yields generated orders.
  ///
  /// Throws an [ArgumentError] if [users] or [products] lists are empty.
  Stream<Order> streamGenerate({
    required List<User> users,
    required List<Product> products,
    int count = 10,
  }) async* {
    if (users.isEmpty || products.isEmpty) {
      throw ArgumentError(
          'User and product lists cannot be empty for streaming orders.');
    }

    for (int i = 0; i < count; i++) {
      final user = Darturbation.randomChoice(users);
      // Determine item count based on user behavior type
      final int itemCount =
          DarturbationCore().patterns.getOrderFrequency(user.behaviorType);

      final items = <Product>[];
      double totalPrice = 0;

      for (int j = 0; j < itemCount; j++) {
        Product product;
        // 75% chance to pick a product from the user's preferred category
        if (Darturbation.randomDouble(0, 1) < 0.75 &&
            user.preferredCategory.isNotEmpty) {
          final preferredProducts = products
              .where((p) => p.category == user.preferredCategory)
              .toList();
          if (preferredProducts.isNotEmpty) {
            product = preferredProducts[
                Darturbation.randomInt(0, preferredProducts.length - 1)];
          } else {
            product = products[Darturbation.randomInt(0, products.length - 1)];
          }
        } else {
          product = products[Darturbation.randomInt(0, products.length - 1)];
        }
        items.add(product);
        totalPrice += product.price;
      }

      yield Order(
        id: Darturbation.generateId(),
        user: user,
        status: Darturbation.randomChoice(IndonesianData.orderStatuses),
        totalAmount: totalPrice,
        shippingCost: Darturbation.randomDouble(5000, 50000),
        discountAmount: Darturbation.randomDouble(0, totalPrice * 0.1),
        paymentMethod: Darturbation.randomChoice(IndonesianData.paymentMethods),
        shippingAddress: IndonesianData.generateAddress(),
        orderDate: DateTime.now()
            .subtract(Duration(days: Darturbation.randomInt(0, 365))),
        items: items,
        metadata: {},
      );
    }
  }
}
