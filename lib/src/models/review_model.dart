part of '../../darturbation.dart';

/// Represents a product review submitted by a user for a specific order.
///
/// This model captures details about a review, including the user who wrote it,
/// the product and order it pertains to, the rating given, and the textual
/// content of the review.
class Review {
  /// A unique identifier for the review.
  final String id;

  /// The [User] who submitted this review.
  final User user;

  /// The [Product] that is being reviewed.
  final Product product;

  /// The [Order] associated with this review, indicating a verified purchase.
  final Order order;

  /// The rating given by the user, typically an integer on a scale (e.g., 1 to 5).
  final int rating;

  /// The title or summary of the review.
  final String title;

  /// The main textual content of the review.
  final String comment;

  /// A list of URLs or paths to images included in the review.
  final List<String> images;

  /// A boolean indicating whether the review is from a verified purchase.
  final bool isVerifiedPurchase;

  /// The date and time when the review was submitted.
  final DateTime reviewDate;

  /// The number of times this review has been marked as helpful by other users.
  final int helpfulCount;

  /// A map for any additional, unstructured metadata related to the review.
  final Map<String, dynamic> metadata;

  /// Creates a [Review] instance.
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

  /// Converts this [Review] instance into a JSON-compatible `Map<String, dynamic>`.
  ///
  /// This method is useful for serialization, storage, or API responses.
  /// It converts [DateTime] objects to ISO 8601 strings and recursively
  /// converts nested [User], [Product], and [Order] objects to their JSON representations.
  ///
  /// Returns a `Map<String, dynamic>` representing the review's data.
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