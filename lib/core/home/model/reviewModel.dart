class ReviewModel {
  final String reviewerName;
  final String comment;
  final double rating;

  ReviewModel({
    required this.reviewerName,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(
      Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName:
          json['reviewerName']?.toString() ?? '',
      comment:
          json['comment']?.toString() ?? '',
      rating:
          (json['rating'] ?? 0).toDouble(),
    );
  }
}