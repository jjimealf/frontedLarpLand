
class ProductReviews {
  final int id;
  final int userId;
  final int productId;
  final int rating;
  final String comment;

  ProductReviews({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.comment,
  });

  factory ProductReviews.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'user_id': int userId,
        'product_id': int productId,
        'rating': int rating,
        'comment': String comment,
      } =>
        ProductReviews(
          id: id,
          userId: userId,
          productId: productId,
          rating: rating,
          comment: comment,
        ),
      _ => throw const FormatException('Falló al cargar la reseña del producto'),
    };
  }
}