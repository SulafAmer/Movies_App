class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final String mediumCoverImage;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      mediumCoverImage: json['medium_cover_image'] ?? '',
    );
  }
}