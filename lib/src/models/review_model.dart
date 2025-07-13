part of '../../darturbation.dart';

class Review {
  final String id;
  final User user;
  final Product product;
  final Order order;
  final int rating;
  final String title;
  final String comment;
  final List<String> images;
  final bool isVerifiedPurchase;
  final DateTime reviewDate;
  final int helpfulCount;
  final Map<String, dynamic> metadata;

  Review({
    required this.id,
    required this.user,
    required this.product,
    required this.order,
    required this.rating,
    required this.title,
    required this.comment,
    required this.images,
    required this.isVerifiedPurchase,
    required this.reviewDate,
    required this.helpfulCount,
    required this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'product': product.toJson(),
      'order': order.toJson(),
      'rating': rating,
      'title': title,
      'comment': comment,
      'images': images,
      'isVerifiedPurchase': isVerifiedPurchase,
      'reviewDate': reviewDate.toIso8601String(),
      'helpfulCount': helpfulCount,
      'metadata': metadata,
    };
  }
}
