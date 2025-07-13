part of '../../darturbation.dart';

/// Generates realistic [Review] data.
///
/// The [ReviewGenerator] creates individual review instances and streams of
/// reviews, ensuring that they are contextually relevant to users, products,
/// and orders, and reflect realistic rating and comment patterns.
class ReviewGenerator {
  /// Generates a single [Review] object.
  ///
  /// This method creates a review with a random rating, a title, and a comment
  /// that is influenced by the user's behavior type and the product's rating.
  /// It also includes other attributes like review date and helpfulness count.
  ///
  /// Parameters:
  /// - [user]: The [User] object who is writing the review.
  /// - [product]: The [Product] object being reviewed.
  /// - [order]: The [Order] object associated with the review.
  ///
  /// Returns a [Review] instance with generated details.
  Review generate({
    required User user,
    required Product product,
    required Order order,
  }) {
    final rating = Darturbation.randomInt(1, 5);
    final title = Darturbation.randomChoice(IndonesianData.reviewTitles);
    final comment = DarturbationCore()
        .patterns
        .generateReviewComment(user.behaviorType, rating.toDouble());

    return Review(
      id: Darturbation.generateId(),
      user: user,
      product: product,
      order: order,
      rating: rating,
      title: title,
      comment: comment,
      images: [],
      isVerifiedPurchase: Darturbation.randomBool(0.9),
      reviewDate: DateTime.now()
          .subtract(Duration(days: Darturbation.randomInt(0, 365))),
      helpfulCount: Darturbation.randomInt(0, 100),
      metadata: {},
    );
  }

  /// Generates a [Stream] of [Review] objects.
  ///
  /// This method is suitable for generating a large number of reviews efficiently
  /// without holding all of them in memory simultaneously. Each review is generated
  /// and yielded as it becomes available.
  ///
  /// Parameters:
  /// - [users]: A [List] of [User] objects who can write reviews.
  /// - [products]: A [List] of [Product] objects that can be reviewed.
  /// - [orders]: A [List] of [Order] objects that reviews are based on.
  /// - [count]: The total number of reviews to generate in the stream (default: 10).
  ///
  /// Returns a [Stream<Review>] that yields generated reviews.
  ///
  /// Throws an [ArgumentError] if [users], [products], or [orders] lists are empty.
  Stream<Review> streamGenerate({
    required List<User> users,
    required List<Product> products,
    required List<Order> orders,
    int count = 10,
  }) async* {
    if (users.isEmpty || products.isEmpty || orders.isEmpty) {
      throw ArgumentError(
          'User, product, and order lists cannot be empty for streaming reviews.');
    }

    for (int i = 0; i < count; i++) {
      final user = Darturbation.randomChoice(users);
      final product = Darturbation.randomChoice(products);
      final order = Darturbation.randomChoice(orders);

      yield generate(
        user: user,
        product: product,
        order: order,
      );
    }
  }
}
