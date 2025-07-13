part of '../../darturbation.dart';

class Order {
  final String id;
  final User user;
  final String status;
  final double totalAmount;
  final double shippingCost;
  final double discountAmount;
  final String paymentMethod;
  final String shippingAddress;
  final DateTime orderDate;
  final DateTime? shippedDate;
  final DateTime? deliveredDate;
  final List<Product> items;
  final Map<String, dynamic> metadata;

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
