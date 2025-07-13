part of '../../darturbation.dart';

class ReviewGenerator {
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
