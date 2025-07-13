part of '../../darturbation.dart';

/// Represents an order placed by a user, containing details about the purchase.
///
/// This model captures comprehensive information about an order, including
/// its unique identifier, the associated user, status, financial details,
/// shipping information, and the list of products purchased.
class Order {
  /// A unique identifier for the order.
  final String id;

  /// The [User] who placed this order.
  final User user;

  /// The current status of the order (e.g., 'pending', 'shipped', 'delivered').
  final String status;

  /// The total monetary amount of the order after discounts and shipping.
  final double totalAmount;

  /// The cost associated with shipping the order.
  final double shippingCost;

  /// The total discount applied to the order.
  final double discountAmount;

  /// The payment method used for the order (e.g., 'Credit Card', 'GoPay').
  final String paymentMethod;

  /// The shipping address for the order.
  final String shippingAddress;

  /// The date and time when the order was placed.
  final DateTime orderDate;

  /// The date and time when the order was shipped. Can be null if not yet shipped.
  final DateTime? shippedDate;

  /// The date and time when the order was delivered. Can be null if not yet delivered.
  final DateTime? deliveredDate;

  /// A list of [Product]s included in this order.
  final List<Product> items;

  /// A map for any additional, unstructured metadata related to the order.
  final Map<String, dynamic> metadata;

  /// Creates an [Order] instance.
  Order({
    required this.id,
    required this.user,
    required this.status,
    required this.totalAmount,
    required this.shippingCost,
    required this.discountAmount,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.orderDate,
    this.shippedDate,
    this.deliveredDate,
    required this.items,
    required this.metadata,
  });

  /// Converts this [Order] instance into a JSON-compatible `Map<String, dynamic>`.
  ///
  /// This method is useful for serialization, storage, or API responses.
  /// It converts [DateTime] objects to ISO 8601 strings and recursively
  /// converts nested [User] and [Product] objects to their JSON representations.
  ///
  /// Returns a `Map<String, dynamic>` representing the order's data.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'status': status,
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'discountAmount': discountAmount,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress,
      'orderDate': orderDate.toIso8601String(),
      'shippedDate': shippedDate?.toIso8601String(),
      'deliveredDate': deliveredDate?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'metadata': metadata,
    };
  }
}